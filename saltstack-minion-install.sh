#!/bin/bash


# Variable for the Ip of salt-master
saltstack_master_ip=$1


# Add saltstack repo
echo "deb [signed-by=/etc/apt/keyrings/salt-archive-keyring-2023.gpg arch=amd64] [https://repo.saltproject.io/salt/py3/ubuntu/22.04/amd64/latest](https://repo.saltproject.io/salt/py3/ubuntu/22.04/amd64/latest) jammy main" | sudo tee /etc/apt/sources.list.d/salt.list


# Install saltstack-master and saltstack-ssh
sudo apt-get update
sudo apt-get install salt-minion salt-ssh -y


# Echo the Ip for the salt-master
echo "master: $saltstack_master_ip" >> /etc/salt/minion


# Enable the salt-minion service
sudo systemctl enable salt-minion
sudo systemctl start salt-minion
sudo systemctl restart salt-minion