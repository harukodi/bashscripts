#!/bin/bash
#Install script for Teleport
EMAIL=$1
DOMAIN_NAME=$2

if [ -z "$EMAIL" ] || [ -z "$DOMAIN_NAME" ]
then
echo "Example: ./install-teleport.sh example@example.com tele.example.com"
exit 1
else
sudo curl https://apt.releases.teleport.dev/gpg -o /usr/share/keyrings/teleport-archive-keyring.asc

echo "deb [signed-by=/usr/share/keyrings/teleport-archive-keyring.asc] \
https://deb.releases.teleport.dev/ stable main" | sudo tee /etc/apt/sources.list.d/teleport.list

sudo apt update
sudo apt install teleport -y

exec teleport configure --acme --acme-email=$EMAIL --cluster-name=$DOMAIN_NAME | \
sudo tee /etc/teleport.yaml
fi