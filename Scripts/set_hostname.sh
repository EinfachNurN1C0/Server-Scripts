#!/bin/bash
HOSTNAME="myhostname"

# Set hostname
sudo hostnamectl set-hostname $HOSTNAME

clear

echo "Your hostname $HOSTNAME was successfully set! You need to reboot your system to apply the changes."