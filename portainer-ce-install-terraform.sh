#!/bin/sh
# Variables for the portainer installation
portainer_pass=$1
portainer_port=$2
# Start of script
echo "$portainer_pass" > /tmp/portainer_password
apt update
apt install docker.io -y
docker pull portainer/portainer-ce
docker volume create portainer_data
docker run -d -p $portainer_port:9443 -p 8000:8000 -v /var/run/docker.sock:/var/run/docker.sock -v /tmp/portainer_password:/tmp/portainer_password portainer/portainer-ce:latest --admin-password-file /tmp/portainer_password
# Clearing the portainer password from /tmp
rm -rf /tmp/portainer_password
