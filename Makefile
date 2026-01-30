BOARD ?= nrf52840dk_nrf52840
APP_DIR ?= app
BUILD_DIR ?= build
ZEPHYR_TOOLCHAIN_VARIANT ?= gnuarmemb
GNUARMEMB_TOOLCHAIN_PATH ?= /usr
WEST_PYTHON ?= $(CURDIR)/.venv/bin/python
FLASH_RUNNER ?= jlink

export ZEPHYR_TOOLCHAIN_VARIANT
export GNUARMEMB_TOOLCHAIN_PATH
export WEST_PYTHON

.PHONY: help setup-host setup-zephyr build clean flash debug gdb menuconfig

help:
	@echo "Targets:"
	@echo "  setup-host    Install host tools (apt + pip)"
	@echo "  setup-zephyr  Initialize and update Zephyr workspace"
	@echo "  build         Build firmware"
	@echo "  flash         Flash firmware"
	@echo "  debug         Start J-Link GDB server"
	@echo "  gdb           Start arm-none-eabi-gdb"
	@echo "  menuconfig    Run menuconfig"
	@echo "  clean         Remove build directory"

setup-host:
	./scripts/setup_host.sh

setup-zephyr:
	./scripts/setup_zephyr.sh

build:
	west build -b $(BOARD) $(APP_DIR) -d $(BUILD_DIR)

flash:
	west flash -d $(BUILD_DIR) -r $(FLASH_RUNNER)

debug:
	./scripts/debug.sh

gdb:
	arm-none-eabi-gdb $(BUILD_DIR)/zephyr/zephyr.elf

menuconfig:
	west build -b $(BOARD) $(APP_DIR) -d $(BUILD_DIR) -t menuconfig

clean:
	rm -rf $(BUILD_DIR)
