#!/bin/bash

echo "1. create user for OpenLogReplicator installation"
sudo adduser olruser
sudo usermod -aG docker olruser

echo "2. build OpenLogReplicator v1.8.5"
sudo -u olruser bash -c '
  cd /home/openlogreplicator-docker || exit 1
  bash ./build-prod.sh
'
echo "- build OpenLogReplicator OK"


echo "- all OK"