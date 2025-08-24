#!/bin/bash

set -e

. cfg.sh

echo "- let's clean OpenLogReplicator checkpoints"
sudo rm -f /home/checkpoint/*
echo "- all OK"