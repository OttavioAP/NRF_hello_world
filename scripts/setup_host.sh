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
