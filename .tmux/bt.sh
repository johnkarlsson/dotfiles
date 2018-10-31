# ᛡᛒ
#!/bin/bash
COL=$(if lsusb | grep -q "Intel Corp."; then echo "#00ff00"; else echo "colour240"; fi)
DEV=$(script -c bluetoothctl <<< quit | grep -Pom1 '(?<=\[)[^\]\[]+(?=])' | sed -r 's/bluetooth//')
printf "["
printf "#[fg=$COL]BT#[default]"
if [ ! -z "$DEV" ]; then
	printf " ("
	printf "#[fg=blue]$DEV#[default]"
	printf ")"
fi
printf "]"
