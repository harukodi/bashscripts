#!/bin/bash
#Script to install openvpn-as

#Password variable for openvpn-as
openvpn_as_password=$1

#Install openvpn-as
sudo apt update 
sudo apt -y install ca-certificates wget net-tools gnupg
sudo wget https://as-repository.openvpn.net/as-repo-public.asc -qO /etc/apt/trusted.gpg.d/as-repository.asc
sudo echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/as-repository.asc] http://as-repository.openvpn.net/as/debian jammy main">/etc/apt/sources.list.d/openvpn-as-repo.list
sudo apt update
sudo apt -y install openvpn-as

#Changing the default password for openvpn-as user
sleep 5
sacli --user openvpn --new_pass $openvpn_as_password SetLocalPassword

#Clearing terminal
clear

#Echo username and password
echo "Username: openvpn password: $openvpn_as_password"
