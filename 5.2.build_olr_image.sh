#!/bin/bash

echo "1. build OpenLogReplicator v1.3.0"
su - olruser
cd /home/openlogreplicator-docker
bash ./build-prod.sh
echo "- build OpenLogReplicator OK"


echo "- all OK"