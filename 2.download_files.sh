#!/bin/bash

echo "1. download Debezium connector Oracle 2.7.4"

mkdir -p /home/custom-connectors
wget https://repo1.maven.org/maven2/io/debezium/debezium-connector-oracle/2.7.4.Final/debezium-connector-oracle-2.7.4.Final-plugin.tar.gz -O /tmp/debezium-connector-oracle-2.7.4.Final-plugin.tar.gz
tar -xvzf /tmp/debezium-connector-oracle-2.7.4.Final-plugin.tar.gz -C /home/custom-connectors


echo "2. download OpenLogReplicator v1.3.0"
mkdir -p /home/openlogreplicator-docker
wget https://github.com/bersler/OpenLogReplicator/archive/refs/tags/v1.3.0.tar.gz -O /tmp/openlogreplciator_1.3.0.tar.gz
tar -xvzf /tmp/openlogreplciator_1.3.0.tar.gz -C /home/openlogreplicator-docker


echo "2. download Oracle 21c XE"
rpm -i https://www.oracle.com/webapps/redirect/signon?nexturl=https://download.oracle.com/otn/linux/oracle21c/oracle-database-ee-21c-1.0-1.ol7.x86_64.rpm
git clone https://github.com/oracle/docker-images.git oracle-docker
mv rpm/oracle-database-xe-21c-1.0-1.ol8.x86_64.rpm /home/oracle-docker/OracleDatabase/SingleInstance/dockerfiles/21.3.0


echo "- all OK"