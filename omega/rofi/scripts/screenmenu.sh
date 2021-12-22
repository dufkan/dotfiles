#!/bin/bash

rofi_command="rofi -theme $DOTFILES/rofi/themes/screenmenu.rasi"

screen=""
area=""
window=""

options="$area\n$screen\n$window"

chosen="$(echo -e "$options" | $rofi_command -dmenu -selected-row 1)"
case $chosen in
    $screen)
        sleep 1; maim $HOME/Pictures/screen-$(date +%s).png && notify-send --urgency=normal "Screenshot" "New screenshot taken"
        ;;
    $area)
        maim -s | xclip -selection clipboard -t image/png
        ;;
    $window)
        sleep 1; maim -u -i $(xdotool getactivewindow) $HOME/Pictures/screen-$(date +%s).png && notify-send --urgency=normal "Screenshot" "New screenshot taken"
        ;;
esac

