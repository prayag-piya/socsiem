#!/usr/bin/env bash
clear

autoscp() {
    echo -n "Enter username: "
    read ans
    if [[ -z "$ans" ]]; then
        clear
        echo "No username selected"
        autoscp
    fi
    echo -n "Enter password: "
    read -s password
    if [[ -z "$ans" ]]; then
        clear
        echo "No password entered."
        autoscp
    fi
    apt install sshpass
    sshpass -p "$password" scp ~/certs.zip $ans@$ip:/home/pnot
    # unzip ~/certs.zip -d ~/certs
    # cp -R ~/certs/ca/ ~/certs/elastcisearch
}
