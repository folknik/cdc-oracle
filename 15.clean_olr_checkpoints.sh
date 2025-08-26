#!/bin/bash

set -e

. cfg.sh

echo "- let's clean OpenLogReplicator checkpoints"
ls -la /home/checkpoint
sudo rm -f /home/checkpoint/*
echo "- all OK"