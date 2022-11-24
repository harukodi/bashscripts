#!/bin/bash

#Install docker
sudo apt update
sudo apt install docker.io -y

#Creating the mountpath for the docker ct
sudo mkdir -p /etc/x-ui/db/
sudo mkdir -p /etc/x-ui/cert/

#cp cert.pem and key.pem to /etc/x-ui/cert/
openssl req -newkey rsa:2048 -new -nodes -x509 -days 3650 -keyout key.pem -out cert.pem -subj "/C=/ST=/L=/O=/OU=/CN="
cp key.pem > /etc/x-ui/cert/key.pem
cp cert.pem > /etc/x-ui/cert/cert.pem

#Creating the docker ct with x-ui
docker run -itd --network=host -v /etc/x-ui/db/:/etc/x-ui/ -v /etc/x-ui/cert/:/root/cert/ --name x-ui --restart=unless-stopped enwaiax/x-ui:latest
