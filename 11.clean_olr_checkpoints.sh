#!/bin/bash

set -e

. cfg.sh

echo "- let's clean OpenLogReplicator checkpoints"
sudo rm -аf /home/checkpoint/*
echo "- all OK"