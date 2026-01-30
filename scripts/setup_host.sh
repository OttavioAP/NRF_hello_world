#!/usr/bin/env bash
set -euo pipefail

sudo apt update
sudo apt install -y cmake ninja-build gcc-arm-none-eabi python3-pip python3-venv device-tree-compiler

if [[ ! -d .venv ]]; then
  python3 -m venv .venv
fi

source .venv/bin/activate
python -m pip install --upgrade pip
pip install west pyelftools intelhex pylink-square

echo "Virtualenv ready at .venv"
echo "Activate with: source .venv/bin/activate"

if command -v nrfutil >/dev/null 2>&1; then
  nrfutil install device
  nrfutil install nrf5sdk-tools
else
  echo "Note: nrfutil not found. Download nRF Util, chmod +x it, and put it on PATH"
  echo "before running this script if you want flashing via the nrfutil runner."
fi
