#!/bin/bash

# Network interface (e.g. eth0)
INTERFACE="eth0"

# Static IP address (e.g. 192.168.*.*)
STATIC_IP="192.168.1.250"

# Gateway und DNS-Server (dein Router oder DNS-Server-IP)
GATEWAY="192.168.1.1"
DNS_SERVER="192.168.1.1"

# Path to netplan config file(You may need to change this)
sudo cp /etc/netplan/50-cloud-init.yaml /etc/netplan/50-cloud-init.yaml.bak

# Configuring netplan
sudo tee /etc/netplan/50-cloud-init.yaml > /dev/null <<EOL
network:
  version: 2
  renderer: networkd
  ethernets:
    $INTERFACE:
      addresses:
        - $STATIC_IP/24
      gateway4: $GATEWAY
      nameservers:
          addresses: [$DNS_SERVER]
EOL

# Apply netplan config
sudo netplan apply

clear

echo "Your static IP was successfully set to $STATIC_IP!"
