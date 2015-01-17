#!/bin/bash
touch ~/dotfiles/.mail/.msmtprc

function write_msmtprc {
    echo $1 >> ~/dotfiles/.mail/.msmtprc
}

function print_settings {
    account_name=$1
    key=$2

    write_msmtprc "account $account_name"
    write_msmtprc "host $(python ~/dotfiles/.mail/get_credential.py $key smtp server)"
    write_msmtprc "port 587"
    write_msmtprc "protocol smtp"
    write_msmtprc "auth on"
    write_msmtprc "from $(python ~/dotfiles/.mail/get_credential.py $key smtp email_address)"
    write_msmtprc "user $(python ~/dotfiles/.mail/get_credential.py $key smtp user)"
    # Note that this outputs only the string below, not the actual evaluation.
    write_msmtprc "passwordeval python ~/dotfiles/.mail/get_credential.py $key smtp password"
}


if ! grep -q '^account tartrate$' ~/dotfiles/.mail/.msmtprc; then
    echo "Writing mailbox_1 settings..."
    print_settings tartrate mailbox_1
    write_msmtprc "tls on"
    write_msmtprc "tls_trust_file ~/.mutt/Equifax_Secure_CA.cert"
    write_msmtprc ""
fi

if ! grep -q '^account kajohn$' ~/dotfiles/.mail/.msmtprc; then
    echo "Writing mailbox_2 settings..."
    print_settings kajohn mailbox_2
    write_msmtprc "tls on"
    write_msmtprc "tls_starttls on"
    write_msmtprc "tls_trust_file /etc/ssl/certs/ca-certificates.crt"
    write_msmtprc ""
fi

if ! grep -q '^account t$' ~/dotfiles/.mail/.msmtprc; then
    echo "Writing mailbox_3 settings..."
    print_settings t mailbox_3
    write_msmtprc "tls on"
    write_msmtprc "tls_trust_file ~/.mutt/Equifax_Secure_CA.cert"
    write_msmtprc ""
fi

if ! grep -q '^account default ' ~/dotfiles/.mail/.msmtprc; then
    echo "Writing account default settings..."
    write_msmtprc "account default : tartrate"
fi

chmod 600 ~/dotfiles/.mail/.msmtprc

echo "Done writing to ~/dotfiles/.mail/.msmtprc."
echo ""
echo "Note: Create a symlink with:"
echo "$ ln -s ~/dotfiles/.mail/.msmtprc ~/.msmtprc"
