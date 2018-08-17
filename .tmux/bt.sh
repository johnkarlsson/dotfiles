# ᛡᛒ
#!/bin/bash
COL=$(if lsusb | grep -q "Intel Corp."; then echo "#00ff00"; else echo "colour240"; fi)
printf "[#[fg=$COL]"
printf "B#[default]]"
