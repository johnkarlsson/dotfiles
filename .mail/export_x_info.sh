#!/bin/bash

# Make sure that this script is run on startup and let crontab source ~/.Xdbus
# to get access to the Gnome keyring. Example (see pullmail.sh):
# */1 * * * * ~/dotfiles/.mail/pullmail_quick.sh
# * */1 * * * ~/dotfiles/.mail/pullmail.sh

# Source:
# http://jason.the-graham.com/2011/01/16/gnome_keyring_with_msmtp_imapfilter_offlineimap/

eval $(gnome-keyring-daemon --start)
export GNOME_KEYRING_SOCKET
export GNOME_KEYRING_PID
# Add to ~/.zshrc to enable ssh-agent to share authentication information
# export SSH_AUTH_SOCK="$GNOME_KEYRING_CONTROL/ssh"

touch $HOME/.Xdbus
chmod 600 $HOME/.Xdbus
env | grep DBUS_SESSION_BUS_ADDRESS > $HOME/.Xdbus
echo 'export DBUS_SESSION_BUS_ADDRESS' >> $HOME/.Xdbus
