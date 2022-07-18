#!/usr/bin/env bash
clear

autoscp() {
    echo -n "Enter username: "
    read ans
    echo -n "Enter Ip Address: "
    read ip
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
    echo -n "Enter path to the zip: "
    read path
    apt install sshpass
    sshpass -p "$password" scp $path $ans@$ip:/home/pnot
    # unzip ~/certs.zip -d ~/certs
    # cp -R ~/certs/ca/ ~/certs/elastcisearch
}

autoscp