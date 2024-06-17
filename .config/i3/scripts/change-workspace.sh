#!/usr/bin/bash

change_workspace() {
  AVAILABLE_WORKSPACES=($(i3-msg -t get_workspaces | jq -r '.[]|"\(.name):\(.visible):\(.focused)"'))
  
  for ROW in "${AVAILABLE_WORKSPACES[@]}"
    do
      IFS=':'
      read WORKSPACE <<< "${ROW}"
      
      NAME="$(echo $WORKSPACE | awk -F' ' '{print $1}')"
      VISIBLE="$(echo $WORKSPACE | awk -F' ' '{print $2}')"
      FOCUSED="$(echo $WORKSPACE | awk -F' ' '{print $3}')"
      
      if [ "${NAME}" == "$1" ]; then
        [ ${FOCUSED} == "true" ] && return 
        if [ "${VISIBLE}" == "true" ]; then
          sh ~/.config/i3/scripts/swap-workspaces.sh "$1"
  	    return
        fi
      fi
    done
  i3-msg -t run_command exec ~/.config/i3/scripts/switch-workspace.py $1
}

change_workspace $1
