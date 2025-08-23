#!/bin/bash

set -e

. cfg.sh

sql /opt/sql/test.sql /opt/sql/test.out
echo "OK"