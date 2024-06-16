#!/usr/bin/bash
WIDTH="$1"
HEIGHT="$2"

xrandr --setmonitor ${MONITOR_1} ${WIDTH}/0x${HEIGHT}/0+0+0 ${HARDWARE_MONITOR_NAME} 
xrandr --setmonitor ${MONITOR_2} ${WIDTH}/0x${HEIGHT}/0+${WIDTH}+0 ${HARDWARE_MONITOR_NAME}