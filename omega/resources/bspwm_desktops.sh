#!/bin/bash

COUNT=$(bspc query -D | wc -l)
NAMES="I II III IV V VI VII VIII IX X XI XII XIII XIV XV XVI XVII XVIII XIX XX"

if [ "$1" == "+" ]
then
    [ "$COUNT" -lt 20 ] && COUNT=$(("$COUNT" + 1))
elif [ "$1" == "-" ]
then
    [ "$COUNT" -gt 1 ] && COUNT=$(("$COUNT" - 1))
fi

bspc monitor eDP1 -d $(echo $NAMES | cut -d' ' -f -$COUNT)
