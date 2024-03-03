#!/bin/bash

# Pull Portainer image
sudo docker pull portainer/portainer-ce:latest || error "Could not pull Portainer image!"

# Create Portainer container
sudo docker run -d -p 9000:9000 -p 9443:9443 --name=Portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/portainer_data portainer/portainer-ce:latest || error "Failed to run Portainer docker image!"

clear

echo "Portainer was successfully installed! You can access it at https://localhost:9443."