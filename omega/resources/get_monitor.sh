#!/bin/bash

xrandr -q | grep ' connected' | grep -v eDP1 | cut -d' ' -f1 | head -1
