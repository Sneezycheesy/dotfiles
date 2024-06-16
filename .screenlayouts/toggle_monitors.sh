#!/usr/bin/bash
MONITOR_1="Virtual-1"
MONITOR_2="Virtual-2"

FULL_WIDTH=$(xrandr | grep "*" | cut -d" " -f4 | awk -F'x' '{print $1}')
WIDTH="$(echo $(( $FULL_WIDTH / 2 )))"
HEIGHT="$(echo $(( $(xrandr | grep "*" | cut -d" " -f4 | awk -F'x' '{print $2}'))))"

echo $WIDTH

function toggle_display {
  if [[ "$1" == "game" || ! -z "$(xrandr --listmonitors | grep Virtual-[12])" ]]; then 
    xrandr --delmonitor $MONITOR_1
    xrandr --delmonitor $MONITOR_2
  else 
    sh $(dirname $0)/default.sh $WIDTH $HEIGHT
  fi
}

toggle_display $1
~/.config/polybar/scripts/load_polybar.sh