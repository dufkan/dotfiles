#!/bin/bash
# https://svkt.org/~simias/lpass

USERNAME=''

status=$(lpass status)

if [ $? -ne 0 ]
then
    if [ "$status" = 'Not logged in.' ]
    then
        DISPLAY=${DISPLAY:-:0} lpass login "$USERNAME" 1>&2
    else
        echo "Lastpass error: $status" 1>&2
        exit 1
    fi
fi

lpass $@
