COMPONENT_SUBMODULES := mynewt-nimble

COMPONENT_ADD_INCLUDEDIRS := \
	include \
	porting/npl/freertos/include \
	porting/nimble/include \
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

COMPONENT_SRCDIRS := \
	porting/npl/freertos/src \
	porting/nimble/src \
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


CFLAGS += "-Wno-error=implicit-function-declaration"