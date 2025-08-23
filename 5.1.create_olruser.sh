#!/bin/bash

echo "1. create user for OpenLogReplicator installation"
sudo adduser olruser
sudo usermod -aG docker olruser

echo "- all OK"