#!/bin/bash

fetch_time=$(date "+%a/%T")

if $(nc -zw 5 www.google.se 443); then
    sudo NEEDRESTART_MODE=a apt-get update -y
    sudo NEEDRESTART_MODE=a apt-get upgrade -y
    # Update notification for discord
    curl -s -H "Accept: application/json" -H "Content-Type:application/json" -X POST --data "{\"content\": \"$(hostname) was updated at $fetch_time\"}" Discord-webhook-goes-here
else
    exit 1
fi