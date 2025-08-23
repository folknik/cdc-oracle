#!/bin/bash

echo "1. create user for OpenLogReplicator installation"
sudo adduser olruser
sudo usermod -aG docker olruser
su - olruser


echo "2. build OpenLogReplicator v1.3.0"
cd /home/openlogreplicator-docker
bash ./build-prod.sh
echo "- build OpenLogReplicator OK"


echo "- all OK"