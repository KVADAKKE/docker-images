#!/bin/bash
docker build --force-rm=true --no-cache=true --build-arg="http_proxy=http://www-proxy.us.oracle.com:80" -t sampleoud:11123 .