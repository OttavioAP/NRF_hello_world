# nRF52840 Zephyr Project

CMake + Ninja + Segger J-Link (CLI) + VS Code (optional)

The goal of this repo is to blink a single led on the nRF52840 DK using Zephyr RTOS. All builds, flashing, and debugging are performed via the command line.  Proprietary tools are used only when unavoidable and strictly via CLI.

---

## Hardware

- Board: nRF52840 DK
- MCU: nRF52840 (Cortex-M4F)
- Debug interface: On-board Segger J-Link (SWD)

---

## Step 1 — Install nRF Util

Download `nrfutil`, make it executable, and place it in a folder on your `PATH`. citeturn0search0

Download page:

```text
https://www.nordicsemi.com/Products/Development-tools/nRF-Util
```

Example (Linux):

```bash
chmod +x nrfutil
mkdir -p ~/.local/bin
mv nrfutil ~/.local/bin/
```

---

## Step 2 — Install Host Tooling

### Requirements

- Linux system
- git
- bash
- python3 (>= 3.8)
- pip

### Install open-source host tools

```bash
./scripts/setup_host.sh
```

This installs:

- cmake
- ninja
- arm-none-eabi-gcc
- device-tree-compiler (dtc)
- a local Python virtualenv at `.venv` with:
  - west (Zephyr meta-tool)
  - pyelftools
  - intelhex

Verify installation:

```bash
arm-none-eabi-gcc --version
cmake --version
ninja --version
west --version
```

Activate the virtualenv when working in this repo:

```bash
source .venv/bin/activate
```

---

## Step 3 — Install Segger J-Link 

Install Segger J-Link manually from https://www.segger.com/downloads/jlink/"


Installed binaries:

- JLinkExe
- JLinkGDBServer

Install and Verify:

```bash
sudo dpkg -i JLink_Linux_VXXX_x86_64.deb
which JLinkExe
JLinkExe --version
```
Expected Location is usually /usr/bin/JLinkExe

> On Linux, USB access may require udev rules. 

---

## Step 3b — Install Nordic nRF Util (recommended)

This repo defaults to the `nrfutil` runner for flashing. Install nRF Util and
the `device` command:

```bash
nrfutil install device
```

Verify:

```bash
which nrfutil
nrfutil device --help
```

If you prefer Nordic's nRF Command Line Tools (`nrfjprog`), set the Makefile
variable:

```bash
make flash FLASH_RUNNER=nrfjprog
```

---

## Step 4 — Initialize Zephyr Workspace

Zephyr and all modules are fetched using `west`, with versions pinned in `west.yml`.

Initialize:

```bash
./scripts/setup_zephyr.sh
```

Set environment variable:

```bash
export ZEPHYR_BASE=$PWD/zephyr
```

(Optional: add to `~/.bashrc`)

Verify:

```bash
west zephyr-export
```

---

## Step 5 — Build Firmware

Build using CMake + Ninja through Zephyr:

```bash
./scripts/build.sh
```

Equivalent manual command:

```bash
west build -b nrf52840dk_nrf52840 app -d build
```

Build outputs:

- `build/zephyr/zephyr.elf`
- `build/zephyr/zephyr.hex`

---

## Makefile Shortcuts

Common actions are available via `make`:

```bash
make build
make flash
make debug
make gdb
```

You can override defaults if needed:

```bash
make build BOARD=nrf52840dk_nrf52840 BUILD_DIR=build APP_DIR=app
```

---

## Step 6 — Flash Firmware

Recommended (Zephyr runner):

```bash
./scripts/flash.sh
```

Direct J-Link flashing (optional):

```bash
JLinkExe -device nRF52840_xxAA -if SWD -speed 4000
```

---

## Step 7 — Debugging with GDB

Start GDB server:

```bash
./scripts/debug.sh
```

This launches:

```text
JLinkGDBServer :2331
```

In another terminal, start GDB:

```bash
arm-none-eabi-gdb build/zephyr/zephyr.elf
```

Inside GDB:

```gdb
target remote :2331
monitor reset halt
load
continue
```

---

## Step 8 — VS Code Extensions

Recommended extensions:

- C/C++
- Cortex-Debug
- CMake Tools
- Zephyr
- NRF Connect


---



## References

- Zephyr documentation: https://docs.zephyrproject.org
- Nordic nRF52840 Product Specification
- Segger J-Link documentation
