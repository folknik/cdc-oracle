#!/bin/bash
# Copyright (C) 2018-2025 Adam Leszczynski (aleszczynski@bersler.com)
#
# This file is part of OpenLogReplicator-tutorials
#
# Open Log Replicator is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License as published
# by the Free Software Foundation; either version 3, or (at your option)
# any later version.
#
# Open Log Replicator is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General
# Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Open Log Replicator; see the file LICENSE.txt  If not see
# <http://www.gnu.org/licenses/>.
set -e

. cfg.sh

echo "1.- Create Log Miner Tablespace in CDB database"
docker exec ${DB_CONTAINER} /bin/bash -c "export NLS_LANG=american_america.AL32UTF8
export ORACLE_SID=XE
. oraenv
sqlplus sys/123@//localhost:1521/XE as sysdba <<- EOF
  CREATE TABLESPACE LOGMINER_TBS DATAFILE '/opt/oracle/oradata/XE/logminer_tbs.dbf' SIZE 25M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED;
  exit;
EOF
"


echo "2.- Create Log Miner Tablespace in PDB database"
docker exec ${DB_CONTAINER} /bin/bash -c "export NLS_LANG=american_america.AL32UTF8
export ORACLE_SID=XE
. oraenv
sqlplus sys/123@//localhost:1521/XEPDB1 as sysdba <<- EOF
  CREATE TABLESPACE LOGMINER_TBS DATAFILE '/opt/oracle/oradata/XE/XEPDB1/logminer_tbs.dbf' SIZE 25M REUSE AUTOEXTEND ON MAXSIZE UNLIMITED;
  exit;
EOF
"

echo "3.- Create common user and its rights"
docker exec ${DB_CONTAINER} /bin/bash -c "export NLS_LANG=american_america.AL32UTF8
export ORACLE_SID=XE
. oraenv
sqlplus sys/123@//localhost:1521/XE as sysdba <<- EOF
  CREATE USER c##dbzuser IDENTIFIED BY dbz DEFAULT TABLESPACE LOGMINER_TBS QUOTA UNLIMITED ON LOGMINER_TBS CONTAINER=ALL;

  GRANT CREATE SESSION TO c##dbzuser CONTAINER=ALL;
  GRANT SET CONTAINER TO c##dbzuser CONTAINER=ALL;
  GRANT SELECT ON SYS.V_$DATABASE TO c##dbzuser CONTAINER=ALL;
  GRANT SELECT ANY DICTIONARY TO c##dbzuser CONTAINER=ALL;
  GRANT LOCK ANY TABLE TO c##dbzuser CONTAINER=ALL;
  -- These can be reduced from ANY TABLE to your captured tables depending on your security model
  GRANT SELECT ANY TABLE TO c##dbzuser CONTAINER=ALL;
  GRANT FLASHBACK ANY TABLE TO c##dbzuser CONTAINER=ALL;

  -- OpenLogReplicator specific permissions
  ALTER SESSION SET CONTAINER = XEPDB1;
  GRANT SELECT, FLASHBACK ON SYS.CCOL$ TO c##dbzuser;
  GRANT SELECT, FLASHBACK ON SYS.CDEF$ TO c##dbzuser;
  GRANT SELECT, FLASHBACK ON SYS.COL$ TO c##dbzuser;
  GRANT SELECT, FLASHBACK ON SYS.DEFERRED_STG$ TO c##dbzuser;
  GRANT SELECT, FLASHBACK ON SYS.ECOL$ TO c##dbzuser;
  GRANT SELECT, FLASHBACK ON SYS.LOB$ TO c##dbzuser;
  GRANT SELECT, FLASHBACK ON SYS.LOBCOMPPART$ TO c##dbzuser;
  GRANT SELECT, FLASHBACK ON SYS.LOBFRAG$ TO c##dbzuser;
  GRANT SELECT, FLASHBACK ON SYS.OBJ$ TO c##dbzuser;
  GRANT SELECT, FLASHBACK ON SYS.TAB$ TO c##dbzuser;
  GRANT SELECT, FLASHBACK ON SYS.TABCOMPART$ TO c##dbzuser;
  GRANT SELECT, FLASHBACK ON SYS.TABPART$ TO c##dbzuser;
  GRANT SELECT, FLASHBACK ON SYS.TABSUBPART$ TO c##dbzuser;
  GRANT SELECT, FLASHBACK ON SYS.TS$ TO c##dbzuser;
  GRANT SELECT, FLASHBACK ON SYS.USER$ TO c##dbzuser;
  GRANT SELECT, FLASHBACK ON XDB.XDB$TTSET TO c##dbzuser;

  DECLARE
    v_sql VARCHAR2(4000);
  BEGIN
    FOR r IN (
      SELECT owner, object_name
      FROM   all_objects
      WHERE  owner = 'XDB'
         AND object_type IN ('TABLE','VIEW')
         AND object_name LIKE 'X$%'
    ) LOOP
      BEGIN
        v_sql := 'GRANT SELECT, FLASHBACK ON '||r.owner||'."'||r.object_name||'" TO c##dbzuser';
        EXECUTE IMMEDIATE v_sql;
      EXCEPTION
        WHEN OTHERS THEN NULL; -- пропустим то, что нельзя/не нужно
      END;
    END LOOP;
  END;
  /

  exit;
EOF
"

echo "- all OK"