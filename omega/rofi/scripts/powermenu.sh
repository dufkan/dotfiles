#!/bin/bash

rofi_command="rofi -theme $DOTFILES/rofi/themes/powermenu.rasi"

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
        usleep 150000; loginctl lock-session
        ;;
    $suspend)
        usleep 150000; systemctl suspend
        ;;
    $log_out)
        bspc quit
        ;;
esac

