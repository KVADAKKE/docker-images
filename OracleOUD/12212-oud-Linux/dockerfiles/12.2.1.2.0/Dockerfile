# LICENSE CDDL 1.0 + GPL 2.0
#
# Copyright (c) 2016-2017 Oracle and/or its affiliates. All rights reserved.
#
# ORACLE  Unified Directory Server DOCKERFILES PROJECT
# -----------------------------------------
# This is the DockerFile for Oracle OUD Server  12.2.1.2.0
#
# IMPORTANT
# -------------------------------------------
# The resulting image of this Dockerfile would have Oracle Linux 7 and Oracle OUD Server 12.2.1.2.0  installed in standalone mode.
# No domain will be configured in this image
#
# For Creating a OUD domain out of above image
# You can go into 'samples/122120-OUD-domain' and build image using DockerFile provided in it
#
# REQUIRED FILES TO BUILD THIS IMAGE
# ----------------------------------
# (1) fmw_12.2.1.2.0_oud_generic_disk1_1of1.zip
#     Download from /ade_autofs/gd17_fmw/IDM_12.2.1.2.0_GENERIC.rdd/LATEST/idm/shiphome/fmw_12.2.1.2.0_oud_generic.jar
#
# HOW TO BUILD THIS IMAGE
# -----------------------
# Put all downloaded files in the same directory as this Dockerfile
# As root user run following command manually:
#
#     $ sh buildDockerImage.sh -v 12.2.1.2.0
#
# Alternatively you can also run
#
#     $ docker build --force-rm=true --no-cache=true --rm=true -t oracle/$IMAGE_NAME:$VERSION-$INSTALL_TYPE .
#
# For example
#
#     $ docker build --force-rm=true --no-cache=true --rm=true -t oracle/oud:12.2.1.2.0-sa . Or
#     $ docker build -t oracle/oud:12.2.1.2.0-sa .
#
# Pull Oracle Linux 7 base image
# -----------------------------------
FROM oracle/jdk:8

# Maintainer
# ------------------------------------
MAINTAINER KARUNAKARN VADAKKEVEEDU <karunakaran.vadakkeveedu@oracle.com>
# Environment variables required for this build (do NOT change)
#     Download from /ade_autofs/gd17_fmw/IDM_12.2.1.2.0_GENERIC.rdd/LATEST/idm/shiphome/fmw_12.2.1.2.0_oud_generic.jar
# ----------------------------------------------
USER root
ENV OUD_PKG=fmw_12.2.1.2.0_oud_generic_disk1_1of1.zip \
    OUD_BIN=fmw_12.2.1.2.0_oud_generic.jar \
    ORACLE_HOME=/u01/oracle/oudssa \
    USER_MEM_ARGS="-Djava.security.egd=file:/dev/./urandom" \
    PATH=$PATH:/usr/sbin:$JAVA_HOME/bin:$ORACLE_HOME/oracle_common/common/bin

# Copy packages to the new drive
# -------------------------------------------------------
# Make Direcotory /u01

COPY $OUD_PKG /u01/

#  Install OL7 required packages. Refer FMW 12.2.1 System requirements guide for complete list of packages
# Change the open file limits and kernel parameters that need changing
# Setup filesystem and oracle user
#---------------------------------------------------------------------------------------------------------
# Proxy needs to be set before running yum in /etc/yum.conf
RUN yum install -y \
        unzip tar nfs-utils binutils ksh sysstat
#RUN yum install -y \
#	compat-libcap1 compat-libstdc++ \
#        gcc gcc-c++ glibc glibc-devel libaio libaio-devel libgcc \
#        libstdc++ libstdc++-devel ksh make ocfs2-tools sysstat && \
RUN  chmod a+xr /u01 && \
    useradd -b /u01 -m -s /bin/bash oracle && \
    echo oracle:oracle | chpasswd && \
    mkdir -p /u01/oracle/.inventory && \
    chown oracle:oracle -R /u01

# Install and configure Oracle JDK
# Go to /u01 as user 'oracle' to proceed with OUD installation
#--------------------------------------------------------
RUN cd /u01 && unzip -q /u01/$OUD_PKG && \
    chown oracle:oracle -R /u01 && \
    printf  'inventory_loc=/u01/oracle/.inventory' > /u01/oraInst.loc
RUN su -c "$JAVA_HOME/bin/java -jar /u01/$OUD_BIN -ignoreSysPrereqs -waitforcompletion -novalidation -silent -invPtrLoc /u01/oraInst.loc DECLINE_SECURITY_UPDATES=true ORACLE_HOME=$ORACLE_HOME" - oracle
#
##RUN cd /u01 && rm $OUD_PKG $OUD_BIN oraInst.loc 

USER oracle
WORKDIR /u01/oracle/

# Define default command to start bash.
CMD ["bash"]
