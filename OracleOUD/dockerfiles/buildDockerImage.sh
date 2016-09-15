#!/bin/bash
cd 11.1.2.3.0
docker build --force-rm=true --no-cache=true --build-arg="http_proxy=http://www-proxy.us.oracle.com:80" -t oracle/oud:11123 .