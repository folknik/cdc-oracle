#!/bin/bash

echo "1. download Debezium connector Oracle 3.2.1"
mkdir -p /home/custom-connectors
wget https://repo1.maven.org/maven2/io/debezium/debezium-connector-oracle/3.2.1.Final/debezium-connector-oracle-3.2.1.Final-plugin.tar.gz -O /tmp/debezium-connector-oracle-3.2.1.Final-plugin.tar.gz
tar -xvzf /tmp/debezium-connector-oracle-3.2.1.Final-plugin.tar.gz -C /home/custom-connectors
echo "- download Debezium connector Oracle OK"


echo "2. download OpenLogReplicator v1.8.5"
mkdir -p /home
git clone https://github.com/bersler/OpenLogReplicator-docker.git openlogreplicator-docker
echo "- download OpenLogReplicator OK"


echo "2. download Oracle 21c XE"
mkdir -p /home/oracle-rpm-package
curl -L https://www.oracle.com/webapps/redirect/signon?nexturl=https://download.oracle.com/otn/linux/oracle21c/oracle-database-ee-21c-1.0-1.ol7.x86_64.rpm -o /home/oracle-rpm-package/oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm
git clone https://github.com/oracle/docker-images.git oracle-docker
mv /home/oracle-rpm-package/oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm /home/oracle-docker/OracleDatabase/SingleInstance/dockerfiles/21.3.0
rm -rf /home/oracle-rpm-package
echo "- download Oracle OK"


echo "- all OK"