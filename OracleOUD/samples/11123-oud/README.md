##Samples for OUD Instance Creation

To give users an idea on how to create an OUD instance from a custom Dockerfile to extend the OUD Install image, we provide a few samples. An example, you can use the sample inside samples/11123-oud folder for creating OUD Instance and for sample data population.

##Building a sample OUD Docker Instance Image

IMPORTANT: You have to build the OUD Install Image before this.

The resulting images will have an instance pre-configured. A set of sample data also will be available.

Go to the folder  : OracleOUD/samples/11123-oud

Run the following command:

$ sh build.sh

or Run the following command:

docker build --force-rm=true --no-cache=true --build-arg="http_proxy=http://www-proxy.us.oracle.com:80" -t sampleoud:11123 .

##OUD Docker Run - To create a container with OUD Instance 

IMPORTANT: You have to build the OUD Instance Image before this.

docker run -d -p (non ssl port):1389 -p (ssl port):1636 --name oud_ldap sampleoud:11.1.2.3.0 startOUD.sh

Eg: docker run -d -p 2389:1389 -p 2636:1636 --name oud_ldap sampleoud:11.1.2.3.0 startOUD.sh


Copyright

Copyright (c) 2016-2017 Oracle and/or its affiliates. All rights reserved.