#!/usr/bin/bash
image_location="/tmp/screenshot.png"
#kitty -e scrot;

# Select desired screenshot area
if [[ $1 == select ]]; then
scrot -s -f -o $image_location
# Grab the whole screen, including all monitors
elif [[ $1 == full ]]; then
scrot -o $image_location
# Grab the current window (not monitor)
elif [[ $1 == current_window ]]; then
scrot -u -o $image_location
# Grab a specific monitor
elif [[ $1 =~ screen[\d]? ]]; then
  # Grep the amount of monitors available
  monitors="$(xrandr --listmonitors | grep -i monitors | cut -d":" -f2 | cut -d" " -f2)"

  # If only one monitor attached, grab it
  if [[ $monitors -eq 1 ]]; then
    scrot -o $image_location
  # if multiple monitors attached add offset of [desired monitor] * [width]
  # Width and height for each monitor has to be the same
  else
    full_width=$(xrandr | grep "*" | cut -d" " -f4 | awk -F'x' '{print $1}')
    width=$(($full_width / $monitors))
    height=$(echo $(( $(xrandr | grep "*" | cut -d" " -f4 | awk -F'x' '{print $2}'))))

    screen=$(echo $1 | cut -d"n" -f2)
    offset=$(( $screen * $width ))

    scrot -a $offset,0,$width,$height -f -o $image_location
  fi
# Grap current monitor
elif [[ $1 == current ]]; then
  # Get focused workspace (grep true)
  # returns something like 
  # [name] true {"x":2565,"y":47,"width":2550,"height":1388}
  focused_workspace=$(i3-msg -t get_workspaces | jq -r '.[]|"\(.name);\(.focused)"' | grep true)
  # Get all active outputs, we only need the workspace name and rectangle coordinates
  outputs=($(i3-msg -t get_outputs | jq -r '.[]|"\(.current_workspace);\(.rect)"'))

  # Grab the workspace name to compare to the output workspaces
  workspace_name=$(echo $focused_workspace | cut -d";" -f1)

  # Loop over the outputs to find the focused workspace
  for ROW in ${outputs[@]}; do
    IFS=";"
    read output <<< $ROW
    # Grab first value which is the current workspace
    name=$(echo $output | cut -d' ' -f1)

    # If the output has the same workspace name as the active workspace
    # Grab the coordinates, x and y offset and width/height
    if [[ $name != "null" && $name == $workspace_name ]]; then
      rect=$(echo $output | cut -d" " -f2)
      x=$(echo $rect | awk -F',' '{print $1}' | cut -d':' -f2)
      y=$(echo $rect | awk -F',' '{print $2}' | cut -d':' -f2)
      width=$(echo $rect | awk -F',' '{print $3}' | cut -d':' -f2)
      height=$(echo $rect | awk -F',' '{print $4}' | cut -d':' -f2 | cut -d'}' -f1)
      # Take screenshot of desired area
      scrot -a $x,$y,$width,$height -f -o $image_location
    fi
  done
fi

xclip -se c -t image/png -i $image_location
