setxkbmap 'se2_qwerty(programmer)'&
stalonetray&
redshift&
nm-applet&
cbatticon -r 4 -c "xbacklight -set 1"&
xinput --set-prop "TPPS/2 IBM TrackPoint" "libinput Accel Speed" 1 &
xmonad --recompile && xmonad
