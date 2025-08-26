#!/bin/sh

export DB_CONTAINER=${DB_CONTAINER:=ORA1}


sql() {
    docker exec ${DB_CONTAINER} /bin/bash -c "export NLS_LANG=american_america.AL32UTF8
export ORACLE_SID=XE
. oraenv
sqlplus / as sysdba <<- EOF
set echo off
set verify off
set heading off
set termout off
set showmode off
set linesize 5000
set pagesize 0
@${1}
EOF
" 1>/dev/null 2>&1
}


sql /opt/sql/11.create_common_user.sql


echo "- all OK"