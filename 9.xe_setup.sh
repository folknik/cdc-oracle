#!/bin/sh

export DB_CONTAINER=${DB_CONTAINER:=oracle}


sql() {
    docker exec ${DB_CONTAINER} /bin/bash -c "
export NLS_LANG=american_america.AL32UTF8
export ORACLE_SID=XE
. oraenv

sqlplus sys/123@//localhost:1521/XE as sysdba <<- EOF
  set echo off
  set verify off
  set heading off
  set termout off
  set showmode off
  set linesize 5000
  set pagesize 0

  spool /dev/stdout
  @${1}
  spool off
EOF
"
}


sql /opt/sql/9.xe_setup.sql


echo "- all OK"