#!/bin/bash

# Update packages
sudo apt update

clear

# Install Docker
curl -sSL https://get.docker.com | sh || error "Could not install Docker!"

# Add your user to the "docker" group to run Docker without "sudo"
sudo usermod -aG docker $USER

# Start Docker
sudo systemctl start docker

# Activate Docker on boot
sudo systemctl enable docker

clear

echo "Docker was successfully installed! Please log out and log back in to apply the changes."
