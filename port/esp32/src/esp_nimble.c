#include "sdkconfig.h"
#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "nimble/nimble_port.h"


static void nimble_host_task(void *arg) {
    nimble_port_run();
}

void esp_nimble_start(void) {
    int core = 0;
    #if CONFIG_BTDM_CONTROLLER_PINNED_TO_CORE_1
        core = 1;
    #endif    
    xTaskCreatePinnedToCore(nimble_host_task, "nimble_host_task", 2048, NULL, 5, NULL, core);
}