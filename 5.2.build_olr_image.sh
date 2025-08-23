#!/bin/bash

echo "1. build OpenLogReplicator v1.3.0"
sudo -u olruser bash -c '
  cd /home/openlogreplicator-docker || exit 1
  bash ./build-prod.sh
'
echo "- build OpenLogReplicator OK"


echo "- all OK"