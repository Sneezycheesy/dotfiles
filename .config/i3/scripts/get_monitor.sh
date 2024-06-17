#!/usr/bin/bash
# This script echoes ("returns") the name of the desired monitor
# The argument passed in is a single integer

# Requirements
# xrandr

# Exit if no monitor value is supplied
[[ -z $1 ]]  && exit

# Get all available monitors
# Grep an inverted match of "monitors" to exclude the first line
MONITORS=$(xrandr --listmonitors | grep -v -i "monitors")

while read MONITOR; do
    # Get the first value of the monitor string which corresponds to the monitor INDEX
    MONITOR_NUM=$(echo $MONITOR | cut -d" " -f1 | cut -d":" -f1)

    # Get the name of the output and "return" it if monitor index is $1 -1
    [[ "$(( ${MONITOR_NUM} + 1))" == "$1" ]] && echo $MONITOR | cut -d" " -f2
    
done <<< ${MONITORS}
