#!/bin/bash
# if upower -i /org/freedesktop/UPower/devices/battery_BAT-3 | grep -q 'state'; then
printf "#[fg=colour240]Batt#[default] "

D="/"
for B in 1 0; do
	if upower -i /org/freedesktop/UPower/devices/battery_BAT$B | grep -q 'state: *charging'; then
	  CHARGING="#[fg=colour120]+#[default]";
	else
	  CHARGING=""
	fi
	POWER=$(upower -i /org/freedesktop/UPower/devices/battery_BAT$B | grep -Po '(?<=percentage: {10})\d+')
	if [[ $POWER -gt 50 ]]; then
	    COLOR='#00FF00';
	elif [[ $POWER -gt 20 ]]; then
	    COLOR='#ffff00';
	else
	    COLOR='#ff0000';
	fi
	printf "$CHARGING#[fg=$COLOR]$POWER#[default]$D"
	D=""
done
