#!/usr/bin/bash
image_location="/tmp/screenshot.png"
#kitty -e scrot;

if [[ $1 == select ]]; then
scrot -s -f -o $image_location

elif [[ $1 == full ]]; then
scrot -o $image_location

elif [[ $1 == current ]]; then
scrot -u -o $image_location

elif [[ $1 == screen0 ]]; then
scrot -a 0,0,1920,1080 -f -o $image_location

elif [[ $1 == screen1 ]]; then
scrot -a 1920,0,1920,1080 -f -o $image_location
fi

xclip -se c -t image/png -i $image_location

#kitty -e flameshot gui
