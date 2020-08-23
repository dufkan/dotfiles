#!/bin/bash
xprop -id "$1" _NET_WM_NAME | grep -q "Emulator" && echo "state=floating"
