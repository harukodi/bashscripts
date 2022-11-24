#!/bin/bash
# init script for shadowsocks-rust with docker

# Variables
port=$1
password=$2
dns=$3

# Install docker
sudo apt update
sudo apt upgrade -y
sudo apt install docker.io -y

# Creating path for shadowsocks-rust-server at /etc/shadowsocks-rust-data/
mkdir /etc/shadowsocks-rust-data/

# Echoing config to /etc/shadowsocks-rust-data/
echo "          
{
  \"server\": \"0.0.0.0\",
  \"server_port\": 8388,
  \"password\": \"$password\",
  \"method\": \"aes-256-gcm\",
  \"mode\": \"tcp_only\",
  \"protocol\": \"dns\",
  \"local_address\": \"0.0.0.0\",
  \"local_port\": 53,
  \"local_dns_port\": 53,
  \"remote_dns_address\": \"$dns\",
  \"remote_dns_port\": 53,
  \"no_delay\": true,
}
" >> /etc/shadowsocks-rust-data/config.json

docker run --name ssserver-rust \
  --restart always \
  -p $port:8388/tcp \
  -p $port:8388/udp \
  -v /etc/shadowsocks-rust-data/config.json:/etc/shadowsocks-rust/config.json \
  -dit ghcr.io/shadowsocks/ssserver-rust:latest
