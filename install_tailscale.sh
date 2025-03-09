#!/bin/bash
tailscale_key=$1

ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N ""
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list
sudo apt-get update && apt-get install tailscale -y
tailscale up --auth-key $tailscale_key --ssh