##OUD LDAP instance on Docker

Sample Docker configurations to facilitate installation, configuration, and oud instance creation for DevOps users. This project includes quick start dockerfiles and samples for OUD Ldap instance based on Oracle Linux and Oracle JDK 7 (Server). The certification of OUD on Docker does not require the use of any file presented in this repository. Customers and users are welcome to use them as starters, and customize/tweak, or create from scratch new scripts and Dockerfiles.

##Building Oracle JDK (Server JRE) base image

Before you can build these oud install images, you must download the Oracle Server JRE binary and drop in folder OracleJDK/java-8 and build that image.

    $ cd OracleJDK/java-8
    $ sh build.sh

##How to Build and Run

This project offers sample Dockerfiles for OUD LDAP instance (12.2.1.2.0). 


##Building OUD Docker Install Images

IMPORTANT: You have to download the binaries of OUD and Oracle JDK and put them in place 

Download the required packages  and drop them in the folder of your distribution version of choice. Then go into the dockerfiles folder and run docker build command as root.Download the OUD 12.2.1.2.0 shiphome ( ofm_oud_generic_12.2.1.2.0_disk1_1of1.zip) and keep in "../OracleOUD/dockerfiles/12.2.1.2.0"

IMPORTANT: the resulting images will NOT have an instance pre-configured. You must extend the image with your own Dockerfile, and create your instance image. You might take a look at the use case samples as well below.

In order to build the install image execute buildDockerImage.sh file under dockerfiles folder or run the below docker build command.

Go to the folder : OracleOUD/dockerfiles

Run the following command:

$ sh buildDockerImage.sh -v 12.2.1.2.0

##Samples for OUD Instance Creation

To give users an idea on how to create an OUD instance from a custom Dockerfile to extend the OUD Install image, we provide a few samples. An example, you can use the sample inside samples/12212-oud folder for creating OUD Instance and for sample data population.

##Building a sample OUD Docker Instance Image


IMPORTANT: You have to build the OUD Install Image before this.

The resulting images will have an instance pre-configured. A set of sample data also will be available.

Go to the folder  : OracleOUD/samples/12212-oud

Run the following command:

$ sh build.sh

##OUD Docker Run - To create a container with OUD Instance 


IMPORTANT: You have to build the OUD Instance Image before this.

docker run -d -p (non ssl port):1389 -p (ssl port):1636 --name oud_ldap sampleoud:12.2.1.2.0 startOUD.sh

Eg: docker run -d -p 2389:1389 -p 2636:1636 --name oud_ldap sampleoud:12.2.1.2.0 startOUD.sh


Copyright

Copyright (c) 2016-2017 Oracle and/or its affiliates. All rights reserved.