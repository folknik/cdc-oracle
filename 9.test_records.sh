#!/bin/bash

set -e

. cfg.sh

echo "1.- Create test records"
sql /opt/sql/test.sql /opt/sql/test.out
echo "OK"