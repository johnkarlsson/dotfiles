#!/bin/bash

function create_account {
    key=$1
    account_name=$2
    email_address=$(python ~/dotfiles/.mail/get_credential.py\
                    $key smtp email_address)
    sed -e "s/\$from/$email_address/g" -e "s/\$account_name/$account_name/g"\
        ~/dotfiles/.mail/.mutt/accounts/template\
        > ~/dotfiles/.mail/.mutt/accounts/$account_name
}

echo "Creating ~/dotfiles/.mail/.mutt/accounts/tartrate ..."
create_account mailbox_1 tartrate
echo "Creating ~/dotfiles/.mail/.mutt/accounts/kajohn ..."
create_account mailbox_2 kajohn
echo "Creating ~/dotfiles/.mail/.mutt/accounts/t ..."
create_account mailbox_3 t
echo ""

echo "Note: Create a symlink with:"
echo "$ ln -s ~/dotfiles/.mail/.mutt ~/.mutt"
