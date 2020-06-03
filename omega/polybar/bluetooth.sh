#!/bin/sh

if [ "$1" = "click" ]
then
    if bluetoothctl show | grep "Powered: yes" > /dev/null
    then
        bluetoothctl power off > /dev/null
        notify-send --urgency=normal "Bluetooth" "Bluetooth Disabled"
    else
        bluetoothctl power on > /dev/null
        notify-send --urgency=normal "Bluetooth" "Bluetooth Enabled"
    fi
fi

if bluetoothctl show | grep "Powered: yes" > /dev/null
then
    echo ' on'
else
    echo '%{F#555} off'
fi
