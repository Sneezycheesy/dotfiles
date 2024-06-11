#!/usr/bin/bash
echo $(ps -u $USER -f | grep "[k]itty --title term")  

if [[ -z $(ps -u $USER -f | grep "[k]itty --title term") ]]; then
  kitty --title term & 
  sleep 1.5
fi
#
i3-msg [title="term"] scratchpad show
