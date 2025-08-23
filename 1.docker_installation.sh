#!/bin/bash

echo "Step 1 — Installing Docker"
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
apt-cache policy docker-ce
sudo apt install docker-ce
echo "- Installing Docker OK"


echo "Step 2 — Executing the Docker Command Without Sudo"
sudo usermod -aG docker ${USER}
su - ${USER}
sudo usermod -aG docker root
echo "- Executing the Docker Command Without Sudo OK"


echo "Step 3 — Installing Docker Compose"
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
echo "- Installing Docker Compose OK"


echo "- ALL OK"