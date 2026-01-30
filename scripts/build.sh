#!/usr/bin/env bash
set -e
west build -b nrf52840dk_nrf52840 app -d build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
