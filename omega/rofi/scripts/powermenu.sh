#!/bin/bash

rofi_command="rofi -theme themes/powermenu.rasi"

power_off=""
reboot=""
lock=""
suspend=""
log_out=""

options="$power_off\n$reboot\n$lock\n$suspend\n$log_out"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 2)"
case $chosen in
    $power_off)
        systemctl poweroff
        ;;
    $reboot)
        systemctl reboot
        ;;
    $lock)
        slock
        ;;
    $suspend)
        systemctl suspend
        ;;
    $log_out)
        bspc quit
        ;;
esac

