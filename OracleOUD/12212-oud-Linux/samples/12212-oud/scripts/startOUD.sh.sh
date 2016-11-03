#!/bin/bash
# Copyright (c) 2016-2017 Oracle and/or its affiliates. All rights reserved.
#
#*************************************************************************
#Tail log file for the container access

/u01/oracle/oudssa/asinst_1/OUD/bin/start-ds

#/u01/oracle/oudssa/asinst_1/OUD/bin/import-ldif --backendID userRoot --append --ldifFile /u01/scripts/OUDContainers.ldif -h localhost -j /u01/scripts/env.list -p $adminConnectorPort -D "cn=Directory Manager"

/u01/oracle/oudssa/asinst_1/OUD/bin/import-ldif --backendID userRoot --append --ldifFile /u01/scripts/ldapadd.ldif -h localhost -j /u01/scripts/env.list -p $adminConnectorPort -D "cn=Directory Manager"

#/u01/oracle/oudssa/asinst_1/OUD/bin/ldapmodify -h localhost -p $OUD_PORT -D "cn=Directory Manager" -j /u01/scripts/env.list -f /u01/scripts/oudadmin.ldif

tail -f /u01/oracle/oudssa/asinst_1/OUD/logs/server.out
