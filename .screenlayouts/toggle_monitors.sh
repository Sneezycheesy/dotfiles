#!/usr/bin/bash
if [[ ! -z "$(xrandr --listmonitors | grep Virtual-[12])" ]]; then 
    xrandr --delmonitor Virtual-1
    xrandr --delmonitor Virtual-2
else 
    sh ~/.screenlayouts/default.sh
fi
