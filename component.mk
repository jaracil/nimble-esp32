COMPONENT_SUBMODULES := mynewt-nimble

COMPONENT_ADD_INCLUDEDIRS := \
	port/esp32/include \
	port/npl/freertos/include \
	mynewt-nimble/porting/nimble/include \
	mynewt-nimble/nimble/include \
	mynewt-nimble/nimble/host/include \
	mynewt-nimble/nimble/host/services/ans/include \
	mynewt-nimble/nimble/host/services/bas/include \
	mynewt-nimble/nimble/host/services/bleuart/include \
	mynewt-nimble/nimble/host/services/gap/include \
	mynewt-nimble/nimble/host/services/gatt/include \
	mynewt-nimble/nimble/host/services/ias/include \
	mynewt-nimble/nimble/host/services/lls/include \
	mynewt-nimble/nimble/host/services/tps/include \
	mynewt-nimble/nimble/host/store/ram/include \
	mynewt-nimble/nimble/host/util/include \
	mynewt-nimble/ext/tinycrypt/include \
	mynewt-nimble/nimble/transport/uart/include \

COMPONENT_EXTRA_INCLUDES := \
	$(IDF_PATH)/components/freertos/include/freertos

COMPONENT_OBJS := \
	mynewt-nimble/nimble/host/services/ans/src/ble_svc_ans.o \
	mynewt-nimble/nimble/host/services/bas/src/ble_svc_bas.o \
	mynewt-nimble/nimble/host/services/gap/src/ble_svc_gap.o \
	mynewt-nimble/nimble/host/services/gatt/src/ble_svc_gatt.o \
	mynewt-nimble/nimble/host/services/ias/src/ble_svc_ias.o \
	mynewt-nimble/nimble/host/services/lls/src/ble_svc_lls.o \
	mynewt-nimble/nimble/host/services/tps/src/ble_svc_tps.o \
	mynewt-nimble/nimble/host/store/ram/src/ble_store_ram.o \
	mynewt-nimble/nimble/host/util/src/addr.o \
	mynewt-nimble/nimble/host/src/ble_att.o \
	mynewt-nimble/nimble/host/src/ble_hs_flow.o \
	mynewt-nimble/nimble/host/src/ble_l2cap.o \
	mynewt-nimble/nimble/host/src/ble_att_clt.o \
	mynewt-nimble/nimble/host/src/ble_hs_hci.o \
	mynewt-nimble/nimble/host/src/ble_l2cap_coc.o \
	mynewt-nimble/nimble/host/src/ble_att_cmd.o \
	mynewt-nimble/nimble/host/src/ble_hs_hci_cmd.o \
	mynewt-nimble/nimble/host/src/ble_l2cap_sig.o \
	mynewt-nimble/nimble/host/src/ble_att_svr.o \
	mynewt-nimble/nimble/host/src/ble_hs_hci_evt.o \
	mynewt-nimble/nimble/host/src/ble_l2cap_sig_cmd.o \
	mynewt-nimble/nimble/host/src/ble_eddystone.o \
	mynewt-nimble/nimble/host/src/ble_hs_hci_util.o \
	mynewt-nimble/nimble/host/src/ble_monitor.o \
	mynewt-nimble/nimble/host/src/ble_gap.o \
	mynewt-nimble/nimble/host/src/ble_hs_id.o \
	mynewt-nimble/nimble/host/src/ble_sm_alg.o \
	mynewt-nimble/nimble/host/src/ble_gattc.o \
	mynewt-nimble/nimble/host/src/ble_hs_log.o \
	mynewt-nimble/nimble/host/src/ble_sm.o \
	mynewt-nimble/nimble/host/src/ble_gatts.o \
	mynewt-nimble/nimble/host/src/ble_hs_mbuf.o \
	mynewt-nimble/nimble/host/src/ble_sm_cmd.o \
	mynewt-nimble/nimble/host/src/ble_gatts_lcl.o \
	mynewt-nimble/nimble/host/src/ble_hs_misc.o \
	mynewt-nimble/nimble/host/src/ble_sm_lgcy.o \
	mynewt-nimble/nimble/host/src/ble_hs_adv.o \
	mynewt-nimble/nimble/host/src/ble_hs_mqueue.o \
	mynewt-nimble/nimble/host/src/ble_sm_sc.o \
	mynewt-nimble/nimble/host/src/ble_hs_atomic.o \
	mynewt-nimble/nimble/host/src/ble_hs_pvcy.o \
	mynewt-nimble/nimble/host/src/ble_store.o \
	mynewt-nimble/nimble/host/src/ble_hs.o \
	mynewt-nimble/nimble/host/src/ble_hs_shutdown.o \
	mynewt-nimble/nimble/host/src/ble_store_util.o \
	mynewt-nimble/nimble/host/src/ble_hs_cfg.o \
	mynewt-nimble/nimble/host/src/ble_hs_startup.o \
	mynewt-nimble/nimble/host/src/ble_uuid.o \
	mynewt-nimble/nimble/host/src/ble_hs_conn.o \
	mynewt-nimble/nimble/host/src/ble_hs_stop.o \
	mynewt-nimble/nimble/host/src/ble_hs_dbg.o \
	mynewt-nimble/nimble/host/src/ble_ibeacon.o \
	mynewt-nimble/nimble/transport/uart/src/ble_hci_uart.o \
	mynewt-nimble/porting/nimble/src/endian.o \
	mynewt-nimble/porting/nimble/src/nimble_port.o \
	mynewt-nimble/porting/nimble/src/os_mbuf.o \
	mynewt-nimble/porting/nimble/src/os_cputime.o \
	mynewt-nimble/porting/nimble/src/os_mempool.o \
	mynewt-nimble/porting/nimble/src/mem.o \
	mynewt-nimble/porting/nimble/src/os_cputime_pwr2.o \
	mynewt-nimble/porting/nimble/src/os_msys_init.o \
	mynewt-nimble/ext/tinycrypt/src/aes_decrypt.o \
	mynewt-nimble/ext/tinycrypt/src/ctr_mode.o \
	mynewt-nimble/ext/tinycrypt/src/ecc_platform_specific.o \
	mynewt-nimble/ext/tinycrypt/src/aes_encrypt.o \
	mynewt-nimble/ext/tinycrypt/src/ctr_prng.o \
	mynewt-nimble/ext/tinycrypt/src/hmac.o \
	mynewt-nimble/ext/tinycrypt/src/cbc_mode.o \
	mynewt-nimble/ext/tinycrypt/src/ecc.o \
	mynewt-nimble/ext/tinycrypt/src/hmac_prng.o \
	mynewt-nimble/ext/tinycrypt/src/ccm_mode.o \
	mynewt-nimble/ext/tinycrypt/src/ecc_dh.o \
	mynewt-nimble/ext/tinycrypt/src/sha256.o \
	mynewt-nimble/ext/tinycrypt/src/cmac_mode.o \
	mynewt-nimble/ext/tinycrypt/src/ecc_dsa.o \
	mynewt-nimble/ext/tinycrypt/src/utils.o	\
	port/npl/freertos/src/nimble_port_freertos.o \
	port/npl/freertos/src/npl_os_freertos.o \
	port/esp32/src/vhci_uart.o \

COMPONENT_SRCDIRS := \
	port/npl/freertos/src \
	port/esp32/src \
	mynewt-nimble/porting/nimble/src \
	mynewt-nimble/ext/tinycrypt/src \
	mynewt-nimble/nimble/transport/uart/src \
	mynewt-nimble/nimble/host/services/ans/src \
	mynewt-nimble/nimble/host/services/bas/src \
	mynewt-nimble/nimble/host/services/gap/src \
	mynewt-nimble/nimble/host/services/gatt/src \
	mynewt-nimble/nimble/host/services/ias/src \
	mynewt-nimble/nimble/host/services/lls/src \
	mynewt-nimble/nimble/host/services/tps/src \
	mynewt-nimble/nimble/host/store/ram/src \
	mynewt-nimble/nimble/host/util/src \
	mynewt-nimble/nimble/host/src \

# Disable type limits warnings 
mynewt-nimble/nimble/host/src/ble_hs_hci_cmd.o: CFLAGS += -Wno-type-limits
mynewt-nimble/nimble/host/src/ble_hs_hci_evt.o: CFLAGS += -Wno-type-limits
mynewt-nimble/porting/nimble/src/os_mempool.o: CFLAGS += -Wno-type-limits
port/npl/freertos/src/npl_os_freertos.o: CFLAGS += -Wno-type-limits
