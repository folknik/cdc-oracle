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
sudo usermod -aG docker root
echo "- Executing the Docker Command Without Sudo OK"


echo "- ALL OK"