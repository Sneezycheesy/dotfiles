#!/usr/bin/bash
[ "${1}" == "1" ] && OUTPUT="${MONITOR_1}"
[ "${1}" == "2" ] && OUTPUT="${MONITOR_2}"

i3-msg focus output ${OUTPUT}
