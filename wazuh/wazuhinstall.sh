#!/usr/bin/env bash

essitial() {
    apt install lsb-release curl apt-transport-https zip unzip gnupg
    curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | apt-key add -
    echo "deb https://packages.wazuh.com/4.x/apt/ stable main" | tee -a /etc/apt/sources.list.d/wazuh.list
    apt update
}

installWazuh() {
    apt install wazuh-manager

}

essential
installWazuh