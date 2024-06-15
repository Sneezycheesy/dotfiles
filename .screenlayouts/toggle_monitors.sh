#!/usr/bin/bash
VIRTUAL_DISPLAY_1="Virtual-1"
VIRTUAL_DISPLAY_2="Virtual-2"

function toggle_display {
  if [[ "$1" == "game" || ! -z "$(xrandr --listmonitors | grep Virtual-[12])" ]]; then 
    xrandr --delmonitor $VIRTUAL_DISPLAY_1
    xrandr --delmonitor $VIRTUAL_DISPLAY_2
  else 
    sh $(dirname $0)/default.sh
  fi
}

toggle_display $1
