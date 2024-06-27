#!/usr/bin/bash
echo $(ps -u $USER -f | grep -i "/usr/bin/lutris" | grep -v grep)

if [[ -z $(ps -u $USER -f | grep -i "/usr/bin/lutris" | grep -v grep) ]]; then
  /usr/bin/lutris &
  sleep 1.1
fi
#
i3-msg [instance="lutris"] scratchpad show
