#!/usr/bin/bash
OUTPUT_FILE=/tmp/screenshot.png

# COLOURS
TEXT="#FFFFFF"
RING="#171A1C"
KEYHL="#104059"
VERIFYING="#0C567B"
WRONG="3A0000"
INSIDE="#0000008A"
DATEFORMAT="%A, %d %b %Y"
RADIUS=155

playerctl pause -a

scrot -f -o $OUTPUT_FILE && \
magick $OUTPUT_FILE -blur 0x8 $OUTPUT_FILE && \
i3lock --image $OUTPUT_FILE -k \
  --indicator \
  --radius $RADIUS \
  --date-str "${DATEFORMAT}" \
  --time-color $TEXT \
  --date-color $TEXT \
  --wrong-color $TEXT \
  --verif-color $TEXT \
  --layout-color $TEXT \
  --keyhl-color $KEYHL \
  --bshl-color ${WRONG} \
  --ring-color $RING \
  --separator-color $RING \
  --ringver-color $VERIFYING \
  --ringwrong-color $WRONG \
  --line-uses-ring \
  --insidever-color $INSIDE \
  --insidewrong-color $INSIDE
