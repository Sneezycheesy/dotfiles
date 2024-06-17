#!/usr/bin/env bash
    # requires jq
    
WORKSPACES=($(i3-msg -t get_workspaces | jq -r '.[]|"\(.name):\(.output):\(.focused)"'))

for ROW in "${WORKSPACES[@]}"
do
    IFS=':'
    read -ra WORKSPACE <<< $ROW
    if [[ ${WORKSPACE[0]} != "null" ]]; then
        if [[ "${WORKSPACE[0]}" == "$1" ]]; then
            TARGET_WORKSPACE_OUTPUT=${WORKSPACE[1]}
        fi
        if [[ $WORKSPACE[0] != $1 && ${WORKSPACE[2]} == "true" ]]; then
            START_WS=${WORKSPACE[0]}
            CURRENT_OUTPUT=${WORKSPACE[1]}
        fi
    fi
done

i3-msg move workspace to output $TARGET_WORKSPACE_OUTPUT
i3-msg workspace $1
i3-msg move workspace to output $CURRENT_OUTPUT
sleep 0.2
i3-msg focus output $CURRENT_OUTPUT