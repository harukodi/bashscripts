#!/bin/bash
#Install script for Teleport
EMAIL=$1
DOMAIN_NAME=$2

if [ -z "$EMAIL" ] || [ -z "$DOMAIN_NAME" ]
then
sudo curl https://apt.releases.teleport.dev/gpg \
-o /usr/share/keyrings/teleport-archive-keyring.asc

source /etc/os-release

echo "deb [signed-by=/usr/share/keyrings/teleport-archive-keyring.asc] \
https://apt.releases.teleport.dev/${ID?} ${VERSION_CODENAME?} stable/v12" \
| sudo tee /etc/apt/sources.list.d/teleport.list > /dev/null
sudo apt-get update
sudo apt-get install teleport

teleport configure --acme --acme-email=$EMAIL --cluster-name=$DOMAIN_NAME | \
sudo tee /etc/teleport.yaml > /dev/null
else
echo "Example: ./install-teleport.sh example@example.com tele.example.com"
fi