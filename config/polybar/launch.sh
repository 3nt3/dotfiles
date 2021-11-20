#!/bin/sh

CPID=$(pgrep -x polybar)

if [ -n "${CPID}" ] ; then
  kill -TERM ${CPID}
fi

# add window titles
# using bspc query here to get monitors in the same order bspwm sees them
export P_BSPWM_WINDOW_CMD="tail ${HOME}/.cache/bspwm_windows_1.txt"

MONITOR=$m polybar --reload example &
