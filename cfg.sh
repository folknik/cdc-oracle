#!/bin/bash

export DB_IMAGE=${DB_IMAGE:=oracle/database:21.3.0-xe}
export DB_CONTAINER=${DB_CONTAINER:=ORA1}
export OLR_IMAGE=${OLR_IMAGE:=bersler/openlogreplicator:debian-13.0}
export OLR_CONTAINER=${OLR_CONTAINER:=OLR1}
export CONFLUENTINC_IMAGE_VERSION=${CONFLUENTINC_IMAGE_VERSION:=7.5.0}
export REDPANDA_CONSOLE_IMAGE=${REDPANDA_CONSOLE_IMAGE:=redpandadata/console:v2.4.3}


sql() {
    docker exec ${DB_CONTAINER} /bin/bash -c "export NLS_LANG=american_america.AL32UTF8
export ORACLE_SID=XE
. oraenv
sqlplus / as sysdba <<EOF
set echo off
set verify off
set heading off
set termout off
set showmode off
set linesize 5000
set pagesize 0
ALTER SESSION SET CONTAINER = XEPDB1;
spool ${2}
@${1}
spool off
EOF
chmod a+r ${2}
" 1>/dev/null 2>&1
}
