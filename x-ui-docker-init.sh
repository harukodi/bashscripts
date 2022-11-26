#!/bin/bash
#Variables
cloudflare_dns_token=$1
x_ui_hostname=$2
cloudflare_email=$3

if [ -z "$cloudflare_dns_token" ] || [ -z "$x_ui_hostname" ] || [ -z "$cloudflare_email" ]
then
echo "token, email or hostname were left empty. Example: sh x-ui-docker-init.sh cloudflare_dns_token x_ui_hostname cloudflare_email"
else
#Install docker
sudo apt update
sudo apt install docker.io -y


#Install certbot for x-ui
sudo snap install core
sudo snap refresh core
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot
sudo snap set certbot trust-plugin-with-root=ok
sudo snap install certbot-dns-cloudflare
mkdir -p ~/.secrets/certbot/
echo "dns_cloudflare_api_token = $cloudflare_dns_token" > ~/.secrets/certbot/cloudflare.ini

#Disallow other users to read the cloudflare.ini file
chmod o-rwx /root/.secrets/certbot/cloudflare.ini

certbot certonly \
  --dns-cloudflare \
  --non-interactive --agree-tos -m $cloudflare_email \
  --dns-cloudflare-credentials ~/.secrets/certbot/cloudflare.ini \
  -d $x_ui_hostname

#Creating the docker ct with x-ui
mkdir -p /etc/x-ui/db/
docker run -itd --network=host -v /etc/x-ui/db/:/etc/x-ui/ -v /etc/letsencrypt/:/root/cert/ --name x-ui --restart=unless-stopped enwaiax/x-ui:latest

#Echo cert.pem/key.pem path for the docker ct
echo "cert.pem and key.pem path for the docker container"
echo "/root/cert/live/$x_ui_hostname/fullchain.pem"
echo "/root/cert/live/$x_ui_hostname/privkey.pem"
fi
