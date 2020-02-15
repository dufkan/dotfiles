#!/bin/sh

if [ "$1" = "click" ]; then
    if [ -f /tmp/dunst_pause ]; then
        killall -SIGUSR2 dunst
        rm -f /tmp/dunst_pause
        notify-send --urgency=normal "Dunst" "Dunst Resumed"
    else
        killall -SIGUSR1 dunst
        touch /tmp/dunst_pause
    fi
fi

[ -f /tmp/dunst_pause ] && echo -n "%{F#555} off"|| echo -n " on"
