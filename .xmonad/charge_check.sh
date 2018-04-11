if upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep -q 'state: *charging'; then
  echo "⚡";
fi
