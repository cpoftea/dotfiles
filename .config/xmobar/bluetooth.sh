#!/bin/bash

DEV=$(bluetoothctl devices | cut -f2 -d ' ' | while read uuid; do bluetoothctl info $uuid; done | grep -e "Connected: yes" | wc -l)
BT="\uf293"

printf "<box type=Top color=#0083fc width=2><fn=3><fc=#0083fc>$BT</fc></fn><hspace=5/>$DEV</box>"
