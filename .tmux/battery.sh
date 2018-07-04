#!/bin/bash
# if upower -i /org/freedesktop/UPower/devices/battery_BAT-3 | grep -q 'state'; then
if upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -q 'state: *charging'; then
  CHARGING="#[fg=colour120]+#[default]";
fi
POWER=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -Po '(?<=percentage: {10})\d+')
if [[ $POWER -gt 99 ]]; then
    COLOR='#00FF00';
elif [[ $POWER -gt 90 ]]; then
    COLOR='colour81';
else
    COLOR='#FF0000';
fi
COLOR="colour$POWER";
printf "#[fg=colour240]Batt#[default] $CHARGING#[fg=$COLOR]$POWER#[default]"
