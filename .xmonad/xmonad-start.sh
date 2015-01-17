#!/bin/bash

# To activate this script, run:
# $ sudo ln -s ~/dotfiles/.xmonad/xmonad-start.sh /usr/local/bin/xmonad-start
# $ sed -i 's/^Exec=xmonad$/Exec=xmonad-start/' /usr/share/xsessions/xmonad.desktop

# # read ~/.Xmodmap if it exists
# if [[ -f "${HOME}/.Xmodmap" ]]; then
#     xmodmap "${HOME}/.Xmodmap" &
# fi

# read ~/.Xresources if it exists
if [[ -f "${HOME}/.Xresources" ]]; then
    xrdb "${HOME}/.Xresources" &
fi

${HOME}/dotfiles/.mail/export_x_info.sh

# nm-applet &

# redshift -l 57.708549:11.975098&
dropbox start

# feh --bg-fill "${HOME}/bg.png"
# nautilus -n &

setxkbmap 'se2(dvorak)'

${HOME}/dotfiles/synclient_mbp.sh

exec xmonad
