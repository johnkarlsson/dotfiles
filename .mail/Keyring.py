#!/usr/bin/python

""" Read and write to the Gnome keyring. Source:
    http://www.clasohm.com/blog/one-entry?entry_id=90957

    To add entries (and check existing):
        $ python Keyring.py setup

    Example use from offlineimap:
        pythonfile = ~/dotfiles/.mail/Keyring.py
        remotehosteval = get_credential("mailbox_1", "imap", "server")
        remoteusereval = get_credential("mailbox_1", "imap", "user")
        remotepasseval = get_credential("mailbox_1", "imap", "password")
    Example use from msmtp (see get_credential.py):
        passwordeval python ~/dotfiles/.mail/get_credential.py mailbox_1 smtp password
"""

import sys
import gtk
import gnomekeyring as gkey
import getpass

class Keyring(object):
    def __init__(self, owner, key, protocol):
        self._owner = owner
        self._key = key
        self._protocol = protocol
        self._keyring = gkey.get_default_keyring_sync()

    def has_credentials(self):
        try:
            attrs = { "key": self._key, "protocol": self._protocol }
            items = gkey.find_items_sync(gkey.ITEM_NETWORK_PASSWORD, attrs)
            return len(items) > 0
        except gkey.DeniedError:
            return False

    def get_credential(self, attribute):
        attrs = { "key": self._key, "protocol": self._protocol }
        items = gkey.find_items_sync(gkey.ITEM_NETWORK_PASSWORD, attrs)
        if (attribute == "password"):
            return items[0].secret
        else:
            return items[0].attributes[attribute]

    def set_credentials(self, (username, password, server)):
        attrs = {
                "key": self._key,
                "user": username,
                "server": server,
                "protocol": self._protocol,
            }
        gkey.item_create_sync(gkey.get_default_keyring_sync(),
                gkey.ITEM_NETWORK_PASSWORD, self._owner, attrs, password, True)

def get_credential(key, protocol, attribute):
    keyring = Keyring("mail", key, protocol)
    return keyring.get_credential(attribute)

""" Call with param [setup] to add and/or read data """
# Doublecheck with $ seahorse
if len(sys.argv) > 1 and sys.argv[1] == "setup":

    doSet = raw_input("Add credential? [y/n]: ")
    if doSet == "y":
        key = raw_input("Key: ")
        protocol = raw_input("Protocol: ")
        username = raw_input("Username: ")
        server = raw_input("Server: ")
        while True:
              password = getpass.getpass(prompt="Password: ")
              p2 = getpass.getpass(prompt="Verify Password: ")
              if p2 != password:
                      print "Passwords don't match."
              else:
                      break
        keyring = Keyring("mail", key, protocol)
        keyring.set_credentials((username, password, server))

    key = raw_input("Fetch credentials for key: ")
    if key != "":
        protocol = raw_input("Protocol: ")
        for a in ["user", "server", "protocol"]:
            print(a + ": " + str(get_credential(key, protocol, a)))
        print("password: " + "*"*len(get_credential(key, protocol, "password")))
