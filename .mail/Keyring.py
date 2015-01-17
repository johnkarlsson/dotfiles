#!/usr/bin/python

""" Read and write to the Gnome keyring. Source:
    http://www.clasohm.com/blog/one-entry?entry_id=90957

    To add entries (and/or check existing):
        $ python Keyring.py setup
    Example input:
        Key: mailbox_1
        Protocol: imap
        Username: user@gmail.com
        Server: imap.gmail.com
        Password:
        Verify Password:
    ...then run again but exchange 'imap' with 'smtp' for msmtprc (see below)

    To double check what is stored:
        $ seahorse

    Example use in ~/.offlineimaprc:
        pythonfile = ~/dotfiles/.mail/Keyring.py
        remotehosteval = get_credential("mailbox_1", "imap", "server")
        remoteusereval = get_credential("mailbox_1", "imap", "user")
        remotepasseval = get_credential("mailbox_1", "imap", "password")
    Example use in ~/.msmtprc (see get_credential.py):
        passwordeval python ~/dotfiles/.mail/get_credential.py mailbox_1 smtp password
"""

import sys
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
            attrs = {"key": self._key, "protocol": self._protocol}
            items = gkey.find_items_sync(gkey.ITEM_NETWORK_PASSWORD, attrs)
            return len(items) > 0
        except gkey.DeniedError:
            return False

    def get_credential(self, attribute):
        item = self._find_item()
        if (attribute == "password"):
            return item.secret
        else:
            return item.attributes.get(attribute, None)

    def _find_item(self):
        items = self._find_items_sync()
        assert len(items) == 1
        return items[0]

    def _find_items_sync(self):
        attrs = {"key": self._key, "protocol": self._protocol}
        return gkey.find_items_sync(gkey.ITEM_NETWORK_PASSWORD, attrs)

    def _clear(self):
        for item in self._find_items_sync():
            print "Deleting old entry..."
            gkey.item_delete_sync(None, item.item_id)

    def set_credentials(self, username, password, server, email_address=None):
        self._clear()
        print "Inserting new entry..."
        attrs = {"key": self._key,
                 "user": username,
                 "server": server,
                 "protocol": self._protocol}
        if email_address:
            attrs['email_address'] = email_address
        gkey.item_create_sync(gkey.get_default_keyring_sync(),
                              gkey.ITEM_NETWORK_PASSWORD,
                              self._owner,
                              attrs,
                              password,
                              True)


def get_credential(key, protocol, attribute):
    keyring = Keyring(owner="mail", key=key, protocol=protocol)
    return keyring.get_credential(attribute)

""" Call with param [setup] to add and/or read data """
if len(sys.argv) > 1 and sys.argv[1] == "setup":
    doSet = raw_input("Add credential? [y/n]: ")
    if doSet == "y":
        key = raw_input("Key: ")
        protocol = raw_input("Protocol: ")
        username = raw_input("Username: ")
        email_address = None
        if protocol == "smtp":
            email_address = raw_input("Email address [{}]: ".format(username))
            email_address = email_address or username
        server = raw_input("Server: ")
        while True:
            password = getpass.getpass(prompt="Password: ")
            p2 = getpass.getpass(prompt="Verify Password: ")
            if p2 != password:
                print "Passwords don't match."
            else:
                break
        keyring = Keyring("mail", key, protocol)
        keyring.set_credentials(username, password, server,
                                email_address=email_address)

    key = raw_input("Fetch credentials for key: ")
    if key != "":
        protocol = raw_input("Protocol: ")
        attributes = ["user", "server", "protocol"]
        if protocol == "smtp":
            attributes.insert(1, "email_address")
        for a in attributes:
            print(a + ": " + str(get_credential(key, protocol, a)))
        show_password = raw_input("Show password? [y/n]: ")
        if show_password == 'y':
            password = get_credential(key, protocol, "password")
            print 'password: {}'.format(get_credential(key, protocol,
                                                       "password"))
