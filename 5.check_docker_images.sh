#!/bin/bash

set -e

. cfg.sh

echo "1. checking docker images"

if [[ "$(docker images -q ${DB_IMAGE} 2> /dev/null)" == "" ]]; then
    echo "Docker image ${DB_IMAGE} not found. Please build it first."
    exit 1
fi

if [[ "$(docker images -q ${OLR_IMAGE} 2> /dev/null)" == "" ]]; then
    echo "Docker image ${OLR_IMAGE} not found. Please build it first."
    exit 1
fi

echo "- all OK"