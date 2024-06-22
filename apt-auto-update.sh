#!/bin/bash

fetch_time=$(date "+%a/%T")
pushover_user_key="user-token-goes-here"
push_over_app_token="app-token-goes-here"

if $(nc -zw 5 www.google.se 443); then
    sudo NEEDRESTART_MODE=a apt-get update -y
    sudo NEEDRESTART_MODE=a apt-get upgrade -y
    # Update notification for pushover
    curl -s -o /dev/null \
      --form-string "token=$push_over_app_token" \
      --form-string "user=$pushover_user_key" \
      --form-string "message=$(hostname) was updated at $fetch_time" \
      https://api.pushover.net/1/messages.json
else
    exit 1
fi