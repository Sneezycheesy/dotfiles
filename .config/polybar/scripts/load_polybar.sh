#!/usr/bin/bash
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload screen0 &
  done
else
  polybar --reload screen0 &
fi
