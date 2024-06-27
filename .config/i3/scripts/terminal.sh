#!/usr/bin/bash
echo $(ps -u $USER -f | grep "[k]itty --title kitty-terminal-emulator")  

if [[ -z $(ps -u $USER -f | grep "[k]itty --title kitty-terminal-emulator") ]]; then
  kitty --title kitty-terminal-emulator & 
  sleep .2
fi
#
i3-msg [title="kitty-terminal-emulator"] scratchpad show
