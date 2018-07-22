#!/bin/bash

awk '/cpu MHz/ {tot += $4; n += 1} END {printf "%1.2fGHz", tot / n / 1000}' /proc/cpuinfo

printf "@"

TEMP_STR=$(grep -Po '(?<=^Core \d: {8}\+)\d+\.\d+..' <(sensors) | sort -h | tail -n 1)
TEMP=$(grep -Po '^\d+' <<< $TEMP_STR)
LOW=60
HIGH=80
if [[ $TEMP -lt $LOW ]]; then
    COLOR='#00ff00';
elif [[ $TEMP -lt $HIGH ]]; then
    COLOR='#ffff00';
else
    COLOR='#ff0000';
fi
printf "#[fg=$COLOR]$TEMP_STR#[default]"
