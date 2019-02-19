# nimble-esp32
ESP32 port of mynewt-nimble BLE library.

## Why?
The official bluetooth stack for ESP32 (Bluedroid) is too heavy.

## Install
Clone this repository inside esp-idf or your project components directory.
`cd components`
`git clone https://github.com/jaracil/nimble-esp32.git`
`git submodule ini`
`git submodule update`

## Examples
There is a repo with examples.

[nimble-esp32-examples](https://github.com/jaracil/nimble-esp32-examples)

## NimBLE Documentation
[NimBLE user guide](https://mynewt.apache.org/latest/network/docs/index.html)

[NimBLE tutorial](https://mynewt.apache.org/latest/tutorials/ble/ble.html)

## To-do
- Add kconfig to configure NimBLE options (Now are hardcoded in port/esp32/include/syscfg/syscfg.h)
- Add CMake support.
- Test in production.
