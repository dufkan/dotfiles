#!/bin/sh
BATTERY='/sys/class/power_supply/BAT0'
if [ `cat ${BATTERY}/status` == 'Discharging' ];
then
    CAPACITY=`cat ${BATTERY}/capacity`
    CAPACITY_COLOR='#[fg=red]'
    [ $CAPACITY -gt 30 ] && CAPACITY_COLOR='#[fg=yellow]'
    [ $CAPACITY -gt 60 ] && CAPACITY_COLOR='#[fg=green]'
    echo -e ${CAPACITY_COLOR}"["${CAPACITY}"%]#[fg=default]"
fi
