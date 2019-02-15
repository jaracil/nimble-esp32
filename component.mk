COMPONENT_SUBMODULES := mynewt-nimble

COMPONENT_PRIV_INCLUDEDIRS := \
include \
mynewt-nimble/nimble/include \
mynewt-nimble/porting/nimble/include \
porting/npl/freertos/include \
mynewt-nimble/nimble/host/include \
mynewt-nimble/ext/tinycrypt/include \
mynewt-nimble/nimble/transport/uart/include

COMPONENT_EXTRA_INCLUDES := \
$(IDF_PATH)/components/freertos/include/freertos

COMPONENT_SRCDIRS := \
mynewt-nimble/nimble/host/src \
mynewt-nimble/nimble/transport/uart/src \
porting/npl/freertos/src

CFLAGS += "-Wno-error=implicit-function-declaration"