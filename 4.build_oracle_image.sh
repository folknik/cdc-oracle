#!/bin/bash

echo "1. build Oracle 21c XE"
cd /home/oracle-docker/OracleDatabase/SingleInstance/dockerfiles
bash ./buildContainerImage.sh -v 21.3.0 -x


echo "- all OK"