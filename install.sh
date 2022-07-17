#!/usr/bin/env bash

RED="\033[1;31m"
GREEN="\033[1;32m"
NOCOLOR="\033[0m"

errcount=0

banner() {
    echo "
    ░██████╗░█████╗░░█████╗░░██████╗██╗███████╗███╗░░░███╗
    ██╔════╝██╔══██╗██╔══██╗██╔════╝██║██╔════╝████╗░████║
    ╚█████╗░██║░░██║██║░░╚═╝╚█████╗░██║█████╗░░██╔████╔██║
    ░╚═══██╗██║░░██║██║░░██╗░╚═══██╗██║██╔══╝░░██║╚██╔╝██║
    ██████╔╝╚█████╔╝╚█████╔╝██████╔╝██║███████╗██║░╚═╝░██║
    ╚═════╝░░╚════╝░░╚════╝░╚═════╝░╚═╝╚══════╝╚═╝░░░░░╚═╝
    "
    echo 
    echo
    echo "1) Install Elasticsearch 7"
    echo "2) Install Elasticsearch 8"
    echo "3) Install Wazuh"
    echo -n "Exit [Q] : "
    read ans
}

updatecache() {
    echo "Installing elasticsearch 7.17.4"
    echo -e "step 1: ${GREEN}update apt cache${NOCOLOR}"
    apt-get update -y
    if [[ $? == 0 ]]; then
        clear
        errcount=$((errcount + 1))
        echo -e "${RED}Failed updating apt cache${NOCOLOR}"
        echo -e "${GREEN}Retrying again: attemp $errcount${NOCOLOR}"
        if [[ $errcount -gt 3 ]]; then
            clear
            echo -e "${RED}Command did not success${NOCOLOR}"
            echo -e "${RED}Please make sure that you are connected to the internet${NOCOLOR}"
            exit 0
        else
            errcount=0
        fi
        updatecache
    fi
}

essitial() {
    echo -e "step 2: ${GREEN}Installing essential support for elasticsearch${NOCOLOR}"
    apt-get install apt-transport-https zip unzip lsb-release curl gnupg -y
    if [[ $? == 0 ]]; then
        clear
        errcount=$((errcount + 1))
        echo -e "${RED}Failed updating apt cache${NOCOLOR}"
        echo -e "${GREEN}Retrying again: attemp $errcount${NOCOLOR}"
        if [[ $errcount -gt 3 ]]; then
            clear
            echo -e "${RED}Command did not success${NOCOLOR}"
            echo -e "${RED}Please make sure that you are connected to the internet${NOCOLOR}"   
            exit 0
        else
            errcount=0
        fi
        essitial
    fi
}

elasticseven() {
    echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | tee /etc/apt/sources.list.d/elastic-7.x.list
    apt-get update
    if [[ $? == 0 ]]; then
        clear
        errcount=$((errcount + 1))
        echo -e "${RED}Failed Addding elasticsearch 7 repo${NOCOLOR}"
        echo -e "${GREEN}Retrying again: attemp $errcount${NOCOLOR}"
        if [[ $errcount -gt 3 ]]; then
            clear
            echo -e "${RED}Command did not success${NOCOLOR}"
            echo -e "${RED}Please make sure that you are connected to the internet${NOCOLOR}"   
            exit 0
        else
            errcount=0
        fi
        elasticseven
    fi
    apt-get install elasticsearch=7.17.4
    curl 
}

while true; do
    banner

    if [[ -z "$ans" ]]; then
        echo "No Value selected here"
        clear
    elif [[ -n "$ans" ]]; then
        if [[ "$ans" == "Q" || "$ans" == "q" ]]; then
            exit 0
        elif [[ "$ans" == "1" ]]; then
            updatecache
            essitial
        fi
    fi
done