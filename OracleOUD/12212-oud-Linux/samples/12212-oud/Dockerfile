# LICENSE CDDL 1.0 + GPL 2.0
#
# Copyright (c) 2016-2017 Oracle and/or its affiliates. All rights reserved.
#
# ORACLE DOCKERFILES PROJECT
# --------------------------
# This Dockerfile extends the OUD install image and configures OUD
#
# HOW TO BUILD THIS IMAGE
# -----------------------
#
#     $ docker build --force-rm=true --no-cache=true --build-arg="http_proxy=http://www-proxy.us.oracle.com:80" -t sampleoud:12212 .
#
# Pull base image
# ---------------
FROM oracle/oud:12.2.1.2.0

# Maintainer
# ----------
MAINTAINER KARUNAKARN VADAKKEVEEDU <karunakaran.vadakkeveedu@oralce.com>

# Node Manager Password (Change it !)
# Setup environment variables
# ----------------------------------------------------------
ENV OUD_PORT=1389 \
    LDAPS_PORT=1636 \
    adminConnectorPort=4444 \
    JAVA_HOME=/usr/java/default \
    MW_HOME=/u01/oracle \
    ORACLE_HOME=/u01/oracle/oudssa \
    PATH=$PATH:/u01/scripts/

# Create necessary dir structure and change owner to oracle user
# -----------------------------------------------------------------
RUN mkdir /u01/oracle/logs /u01/scripts && \
    chown -R oracle:oracle /u01/oracle/*

# Copy required files to build this image
# ------------------------------------------------------
USER oracle

COPY scripts/env.list /u01/scripts
COPY scripts/*.ldif /u01/scripts/
COPY scripts/startOUD.sh /u01/scripts

#COPY env.list /u01/passwordfile
#COPY startOUD.sh /u01/passwordfile
#COPY OUDContainers.ldif /u01/SampleData
#COPY oudadmin.ldif /u01/SampleData


# Configuration of OUD domain
# Copy static html for sanity check
#---------------------------------------------------
RUN $ORACLE_HOME/oud/oud-setup --cli --no-prompt -Q -p $OUD_PORT --adminConnectorPort $adminConnectorPort -D "cn=Directory Manager" -q --generateSelfSignedCertificate --ldapsPort $LDAPS_PORT -j /u01/scripts/env.list -a -b dc=us,dc=oracle,dc=com

#Expose all Ports
EXPOSE $OUD_PORT $LDAPS_PORT $adminConnectorPort

USER root
RUN chmod 777 /u01/scripts/*.*

# Final setup
USER oracle
WORKDIR /u01/scripts

# Define default command to start bash
#CMD ["/u01/oracle/asinst_1/OUD/bin/start-ds"]
CMD ["bash"]
