#!/usr/bin/bash
killall polybar

if type "xrandr"; then
  for m in $(polybar -m | cut -d":" -f1); do
    MONITOR=$m polybar --reload screen0 &
  done
else
  polybar --reload screen0 &
fi
