#!/bin/bash

TMPBG=/tmp/screen.png
DUNST_PAUSE=/tmp/dunst_pause

pre_lock() {
    rectangles=" "
    SR=$(xrandr --query | grep ' connected' | grep -o '[0-9][0-9]*x[0-9][0-9]*[^ ]*')
    for RES in $SR; do
      SRA=(${RES//[x+]/ })
      CX=$((${SRA[2]} + 25))
      CY=$((${SRA[1]} - 80))
      rectangles+="rectangle $CX,$CY $((CX+300)),$((CY-80)) "
    done
    maim $TMPBG && convert $TMPBG -scale 5% -scale 2000% -draw "fill black fill-opacity 0.4 $rectangles" $TMPBG
    killall -SIGUSR1 dunst # pause dunst
    return
}

do_lock() {
    i3lock \
      -i $TMPBG \
      --indpos="x+290:h-120" \
      --timepos="ix-180:iy" \
      --datepos="tx+24:ty+25" \
      --clock \
      --datestr "Type password to unlock..." \
    \
      --insidecolor=00000000 \
      --insidevercolor=fecf4dff \
      --insidewrongcolor=d23c3dff \
    \
      --ringcolor=ffffffff \
      --ringvercolor=ffffffff \
      --ringwrongcolor=ffffffff \
    \
      --line-uses-inside \
      --keyhlcolor=d23c3dff \
      --bshlcolor=d23c3dff \
      --separatorcolor=00000000 \
      --radius=20 \
      --ring-width=3 \
    \
      --veriftext="" \
      --wrongtext="" \
      --noinputtext="" \
      --locktext="" \
      --lockfailedtext="" \
    \
      --verifcolor=ffffffff \
      --wrongcolor=ffffffff \
      --timecolor=ffffffff \
      --datecolor=ffffffff \
    $LOCK_EXTRA_ARGS
    return
}

post_lock() {
    rm $TMPBG
    [ -f "$DUNST_PAUSE" ] || killall -SIGUSR2 dunst # resume dunst
    return
}


pre_lock

# We set a trap to kill the locker if we get killed, then start the locker and
# wait for it to exit. The waiting is not that straightforward when the locker
# forks, so we use this polling only if we have a sleep lock to deal with.
if [[ -e /dev/fd/${XSS_SLEEP_LOCK_FD:--1} ]]; then
    kill_i3lock() {
        pkill -xu $EUID "$@" i3lock
    }

    trap kill_i3lock TERM INT

    # we have to make sure the locker does not inherit a copy of the lock fd
    LOCK_EXTRA_ARGS='{XSS_SLEEP_LOCK_FD}<&-'
    do_lock

    # now close our fd (only remaining copy) to indicate we're ready to sleep
    exec {XSS_SLEEP_LOCK_FD}<&-

    while kill_i3lock -0; do
        sleep 0.5
    done
else
    trap 'kill %%' TERM INT
    LOCK_EXTRA_ARGS='-n &'
    do_lock
    wait
fi

post_lock
