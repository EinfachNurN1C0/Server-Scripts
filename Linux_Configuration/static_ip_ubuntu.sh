#!/bin/bash

# Network interface (e.g. eth0)
INTERFACE="eth0"

# Static IP address (e.g. 192.168.*.*)
STATIC_IP="myip"

# DNS server (e.g. Your router's IP address or DNS server's IP address)
DNS_SERVER="mydns"

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
      nameservers:
          addresses: [$DNS_SERVER]
      routes:
        - to: default
          via: $DNS_SERVER

# Apply netplan config
sudo netplan apply

clear

echo "Your static IP was successfully set to $STATIC_IP!"
