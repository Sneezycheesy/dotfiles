#!/usr/bin/bash
WIDTH="$(echo $(( $(xrandr | grep "*" | cut -d" " -f4 | awk -F'x' '{print $1}') / 2 )))"
HEIGHT="$(echo $(( $(xrandr | grep "*" | cut -d" " -f4 | awk -F'x' '{print $2}'))))"
xrandr --setmonitor Virtual-1 ${WIDTH}/0x${HEIGHT}/0+0+0 ${HARDWARE_MONITOR_NAME} 
xrandr --setmonitor Virtual-2 ${WIDTH}/0x${HEIGHT}/0+${WIDTH}+0 ${HARDWARE_MONITOR_NAME}
