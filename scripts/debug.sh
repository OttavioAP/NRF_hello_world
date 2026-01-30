#!/usr/bin/env bash
set -e
JLinkGDBServer -device nRF52840_xxAA -if SWD -speed 4000
