#!/bin/sh

. cfg.sh

docker exec ${DB_CONTAINER} /bin/bash -c "
  export NLS_LANG=american_america.AL32UTF8
  export ORACLE_SID=XE
  . oraenv

  sqlplus sys/123@//localhost:1521/XE as sysdba <<- EOF
    CREATE TABLESPACE LOGMINER_TBS DATAFILE '/opt/oracle/oradata/XE/logminer_tbs.dbf' SIZE 25M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED;
    EXIT;
  EOF
"

echo "- all OK"