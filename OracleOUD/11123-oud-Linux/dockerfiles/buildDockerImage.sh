#!/bin/bash
#
# Since: September, 2016
# Author: karunakaran.vadakkeveedu@oralce.com
# Description: script to build a Docker image for OUD.
#
#
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES OR THIS HEADER.
#
# Copyright (c) 2016-2017 Oracle and/or its affiliates. All rights reserved.
#
#
usage() {
cat << EOF

Usage: buildDockerImage.sh -v [version] [-s]
Builds a Docker Image for OUD .

Parameters:
   -v: Release version to build. Required. E.g 11.1.2.3.0
   -s: skips the MD5 check of packages


Copyright (c) 2016-2017: Oracle and/or its affiliates. All rights reserved.


EOF
exit 0
}


# Validate packages
checksumPackages() {
  echo "Checking if required packages are present and valid..."
  md5sum -c *.download
  if [ "$?" -ne 0 ]; then
    echo "MD5 for required packages to build this image did not match!"
    echo "Make sure to download missing files in folder dockerfiles. See *.download files for more information"
    exit $?
  fi
}


#Parameters
VERSION="11.1.2.3.0"
SKIPMD5=0
while getopts "hsdgiv:" optname; do
  case "$optname" in
    "h")
      usage
      ;;
    "s")
      SKIPMD5=1
      ;;
    "v")
      VERSION="$OPTARG"
      ;;
	 *)
    # Should not occur
      echo "Unknown error while processing options inside buildDockerImage.sh"
      ;;
  esac
done

# OUD Image Name
IMAGE_NAME="oracle/oud:$VERSION"

cd $VERSION

if [ ! "$SKIPMD5" -eq 1 ]; then
  checksumPackages
else
  echo "Skipped MD5 checksum."
fi

# Proxy settings
PROXY_SETTINGS=""
if [ "${http_proxy}" != "" ]; then
  PROXY_SETTINGS="$PROXY_SETTINGS --build-arg=\"http_proxy=${http_proxy}\""
fi

if [ "${https_proxy}" != "" ]; then
  PROXY_SETTINGS="$PROXY_SETTINGS --build-arg=\"https_proxy=${https_proxy}\""
fi

if [ "${ftp_proxy}" != "" ]; then
  PROXY_SETTINGS="$PROXY_SETTINGS --build-arg=\"ftp_proxy=${ftp_proxy}\""
fi

if [ "${no_proxy}" != "" ]; then
  PROXY_SETTINGS="$PROXY_SETTINGS --build-arg=\"no_proxy=${no_proxy}\""
fi

if [ "$PROXY_SETTINGS" != "" ]; then
  echo "Proxy settings were found and will be used during build."
fi

# ################## #
# BUILDING THE IMAGE #
# ################## #
echo "Building image '$IMAGE_NAME' ..."
echo "Proxy Settings '$PROXY_SETTINGS'"
# BUILD THE IMAGE (replace all environment variables)
BUILD_START=$(date '+%s')
docker build --force-rm=true --no-cache=true $PROXY_SETTINGS -t $IMAGE_NAME -f Dockerfile . || {
  echo "There was an error building the image."
  exit 1
}
BUILD_END=$(date '+%s')
BUILD_ELAPSED=`expr $BUILD_END - $BUILD_START`

echo ""

if [ $? -eq 0 ]; then
cat << EOF
  OUD Docker Image for version: $VERSION is ready to be extended.

    --> $IMAGE_NAME

  Build completed in $BUILD_ELAPSED seconds.

EOF
else
  echo "OUD Docker Image was NOT successfully created. Check the output and correct any reported problems with the docker build operation."
fi