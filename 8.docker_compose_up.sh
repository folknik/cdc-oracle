#!/bin/bash

set -e

. cfg.sh

echo "3. creating and starting db container"

docker-compose -f docker-compose.yml up --detach

echo "- all OK"