#!/usr/bin/env bash
set -e
sudo apt update
sudo apt install -y cmake ninja-build gcc-arm-none-eabi python3-pip
pip3 install --user west
