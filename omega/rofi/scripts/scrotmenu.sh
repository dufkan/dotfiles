#!/bin/bash

rofi_command="rofi -theme $DOTFILES/rofi/themes/scrotmenu.rasi"

screen=""
area=""
window=""

options="$area\n$screen\n$window"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 1)"
case $chosen in
    $screen)
        sleep 3; scrot --quality 100 $HOME/Screenshots/screen-`date +%s`.jpg && notify-send --urgency=normal "Screenshot" "New screenshot taken"
        ;;
    $area)
        scrot -s --quality 100 $HOME/Screenshots/screen-`date +%s`.jpg
        ;;
    $window)
        sleep 3; scrot -u --quality 100 $HOME/Screenshots/screen-`date +%s`.jpg && notify-send --urgency=normal "Screenshot" "New screenshot taken"

        ;;
esac

