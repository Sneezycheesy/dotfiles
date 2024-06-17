#!/usr/bin/bash
# This script helps easily focusing an OUTPUT
# or moving the current window to an OUTPUT
# Depending on how the outputs/monitors have been set up

OUTPUT=$($(dirname $0)/get_monitor.sh $1)

[[ -z $OUTPUT ]] && exit

case $2 in
    focus ) i3-msg focus output ${OUTPUT};;
    move ) i3-msg move window output ${OUTPUT};;
    * ) exit;;
esac
