Place se2 in /usr/share/X11/xkb/symbols

Based on Svorak A5 http://aoeu.info/s/dvorak/svorak

#### Loading

$ setxkbmap 'se2(dvorak)'

##### If your settings keep getting reset

$ sudo ibus-setup

Advanced > Use system keyboard layout

...and while you're at it, delete the c-space binding:

General > Next input method (...) > Delete > Ok
