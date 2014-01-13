#!/bin/bash

# Run this on startup and let crontab source ~/.Xdbus to get access to the Gnome
# keyring

# Source:
# http://jason.the-graham.com/2011/01/16/gnome_keyring_with_msmtp_imapfilter_offlineimap/

touch $HOME/.Xdbus
chmod 600 $HOME/.Xdbus
env | grep DBUS_SESSION_BUS_ADDRESS > $HOME/.Xdbus
echo 'export DBUS_SESSION_BUS_ADDRESS' >> $HOME/.Xdbus
