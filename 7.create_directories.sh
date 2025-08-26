#!/bin/bash

set -e

. cfg.sh

echo "2. creating directories"

mkdir oradata
chmod 755 oradata
sudo chown 54321:54321 oradata

mkdir fra
chmod 755 fra
sudo chown 54321:54321 fra

#chmod a+x+r+w sql
#chmod a+r sql/*.sql

mkdir checkpoint
chmod 777 checkpoint

mkdir log
chmod 777 log

mkdir output
chmod 777 output

chmod 777 scripts
chmod 644 scripts/OpenLogReplicator.json

chmod 777 setup
chmod 644 setup/config.sql

echo "- all OK"