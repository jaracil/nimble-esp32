#include "hal/hal_uart.h"
#include "esp_log.h"
#include "freertos/FreeRTOS.h"
#include "freertos/event_groups.h"
#include "freertos/task.h"
#include "esp_bt.h"


#define LOG_TAG "vhci-uart"

#define EVT_FL_START_TX (1 << 0)
#define EVT_FL_START_RX (1 << 1)
#define EVT_FL_VHCI_AVAIL (1 << 2)
#define EVT_FL_OPEN (1 << 3)
#define EVT_FL_CLOSE (1 << 4)


static hal_uart_tx_char tx_char_cb;
static hal_uart_rx_char rx_char_cb;
static hal_uart_tx_done tx_done_cb;
static void *cb_arg;
static EventGroupHandle_t evt_flags;
static bool uart_open;
esp_bt_controller_config_t bt_cfg = BT_CONTROLLER_INIT_CONFIG_DEFAULT();
static bool controller_init;
static bool controller_enable;
static bool task_create;


static int wait_open() {
    while(!uart_open) {
        xEventGroupWaitBits(evt_flags, EVT_FL_OPEN, pdTRUE, pdFALSE, portMAX_DELAY);
    }
    return 0; 
}

static int wait_start_tx() {
    EventBits_t ev_bits;
    while(true) {
        ev_bits = xEventGroupWaitBits(evt_flags, EVT_FL_START_TX | EVT_FL_CLOSE, pdTRUE, pdFALSE, portMAX_DELAY);
        if (ev_bits & EVT_FL_CLOSE) {
            return -1;
        }
        if (ev_bits & EVT_FL_START_TX) {
            return 0;
        }
    }
}

static int wait_start_rx() {
    EventBits_t ev_bits;
    while(true) {
        ev_bits = xEventGroupWaitBits(evt_flags, EVT_FL_START_RX | EVT_FL_CLOSE, pdTRUE, pdFALSE, portMAX_DELAY);
        if (ev_bits & EVT_FL_CLOSE) {
            return -1;
        }
        if (ev_bits & EVT_FL_START_RX) {
            return 0;
        }
    }
}

static int wait_vhci_avail() {
    EventBits_t ev_bits;
    while(!esp_vhci_host_check_send_available()) {
        ev_bits = xEventGroupWaitBits(evt_flags, EVT_FL_VHCI_AVAIL | EVT_FL_CLOSE, pdTRUE, pdFALSE, portMAX_DELAY);
        if (ev_bits & EVT_FL_CLOSE) {
            return -1;
        }
        if (ev_bits & EVT_FL_VHCI_AVAIL) {
            return 0;
        }
    }
    return 0;
}

void notify_host_send_available(void) {
    ESP_LOGI(LOG_TAG, "notify_host_send_available call");
    xEventGroupSetBits(evt_flags, EVT_FL_VHCI_AVAIL);
}
    
int notify_host_recv(uint8_t *data, uint16_t len) {
    ESP_LOGI(LOG_TAG, "notify_host_recv call");
    for (int idx = 0; idx < len; idx ++){
        while (rx_char_cb(cb_arg, data[idx]) == -1) {
            if(wait_start_rx() == -1) return 0;
        }
    }
    ESP_LOGI(LOG_TAG, "recv %d bytes from vhci", len);
    for(int i = 0; i < len; i++) {
        printf("%02x ", data[i]);
    }
    printf("\n");

    return 0;
}

static esp_vhci_host_callback_t vhci_cb = {
    .notify_host_send_available = notify_host_send_available,
    .notify_host_recv = notify_host_recv
};


static void uart_task(void *arg) {
    int data;
    uint8_t buf[256];
    int buf_sz = 0;

    while(true) {
        wait_open();
        ESP_LOGI(LOG_TAG, "uart openned");
        while(uart_open) {
            if (wait_start_tx() != 0) break;
            buf_sz = 0;
            while ((data = tx_char_cb(cb_arg)) >= 0) {
                buf[buf_sz] = data;
                buf_sz ++;
            }
            if (wait_vhci_avail() != 0) break;
            ESP_LOGI(LOG_TAG, "send %d bytes to vhci", buf_sz);
            for(int i = 0; i < buf_sz; i++) {
                printf("%02x ", buf[i]);
            }
            printf("\n");
            esp_vhci_host_send_packet(buf, buf_sz);
        }
    }
}

int hal_uart_init_cbs(int uart, hal_uart_tx_char tx_func, hal_uart_tx_done tx_done, hal_uart_rx_char rx_func, void *arg) {

    if (!uart_open) {
        tx_char_cb = tx_func;
        rx_char_cb = rx_func;
        tx_done_cb = tx_done;
        cb_arg = arg;
        
        if (evt_flags == NULL) evt_flags = xEventGroupCreate();

        if (esp_bt_controller_mem_release(ESP_BT_MODE_CLASSIC_BT)) {
            ESP_LOGI(LOG_TAG, "Bluetooth controller release classic bt memory failed");
            return -1;
        }        
        if (!controller_init) {
            if(esp_bt_controller_init(&bt_cfg)) {
                ESP_LOGE(LOG_TAG, "%s initialize controller failed", __func__);
                return -1;
            }
            controller_init = true;
        }
        if (!controller_enable){
            esp_vhci_host_register_callback(&vhci_cb);

            if (esp_bt_controller_enable(ESP_BT_MODE_BLE)) {
                ESP_LOGE(LOG_TAG, "%s enable controller failed", __func__);
                return -1;
            }
            controller_enable = true;
        }
        if (!task_create) {
            task_create = true;
            xTaskCreatePinnedToCore(uart_task, "uart_task", 2048, NULL, 5, NULL, 0);
        }

        uart_open = true;
        xEventGroupSetBits(evt_flags, EVT_FL_OPEN);
        ESP_LOGI(LOG_TAG, "hal_uart_init_cbs call uart:%d", uart);
        return 0;
    }
    return -1;
}

int hal_uart_init(int uart, void *cfg) {
    ESP_LOGI(LOG_TAG, "hal_uart_init call");
    return 0;
}

int hal_uart_config(int uart, int32_t speed, uint8_t databits, uint8_t stopbits, enum hal_uart_parity parity, enum hal_uart_flow_ctl flow_ctl) {
    ESP_LOGI(LOG_TAG, "hal_uart_config call");
    return 0;
}

int hal_uart_close(int uart) {
    ESP_LOGI(LOG_TAG, "hal_uart_close");
    if (uart_open) {
        if (controller_enable) {
            if (esp_bt_controller_disable()) {
                ESP_LOGE(LOG_TAG, "%s disable controller failed", __func__);
                return -1;
            }
            controller_enable = false;
        }
        uart_open = false;
        xEventGroupSetBits(evt_flags, EVT_FL_CLOSE);
    }
    return 0;
}

void hal_uart_start_tx(int uart) {
    ESP_LOGI(LOG_TAG, "hal_uart_start_tx call");
    xEventGroupSetBits(evt_flags, EVT_FL_START_TX);
    return ;
}

void hal_uart_start_rx(int uart) {
    ESP_LOGI(LOG_TAG, "hal_uart_start_rx call");
        xEventGroupSetBits(evt_flags, EVT_FL_START_RX);
    return ;
}

void hal_uart_blocking_tx(int uart, uint8_t byte) {
    ESP_LOGI(LOG_TAG, "hal_uart_blocking_tx call");
    assert(0);
}
