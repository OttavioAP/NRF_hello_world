#!/usr/bin/env bash
set -e
west init -l .
west update
west zephyr-export
