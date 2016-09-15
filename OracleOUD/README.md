##OUD LDAP instance on Docker

Sample Docker configurations to facilitate installation, configuration, and oud instance creation for DevOps users. This project includes quick start dockerfiles and samples for OUD Ldap instance based on Oracle Linux and Oracle JDK 7 (Server). The certification of OUD on Docker does not require the use of any file presented in this repository. Customers and users are welcome to use them as starters, and customize/tweak, or create from scratch new scripts and Dockerfiles.

##Building Oracle JDK (Server JRE) base image

Before you can build these oud install images, you must download the Oracle Server JRE binary and drop in folder OracleJDK/java-7 and build that image.

    $ cd OracleJDK/java-7
    $ sh build.sh

##How to Build and Run

This project offers sample Dockerfiles for OUD LDAP instance (11.1.2.3.0). 


##Building OUD Docker Install Images

IMPORTANT: You have to download the binaries of OUD and Oracle JDK and put them in place 

Download the required packages  and drop them in the folder of your distribution version of choice. Then go into the dockerfiles folder and run docker build command as root.
Download the OUD 11.1.2.3.0 shiphome ( ofm_oud_generic_11.1.2.3.0_disk1_1of1.zip) and keep in "../OracleOUD/dockerfiles/11.1.2.3.0"

IMPORTANT: the resulting images will NOT have an instance pre-configured. You must extend the image with your own Dockerfile, and create your instance image. You might take a look at the use case samples as well below.

In order to build the instance image execute **buildDockerImage.sh** file under **dockerfiles** folder or run the below docker build command.

Command : docker build --force-rm=true --no-cache=true --build-arg="http_proxy=http://www-proxy.us.oracle.com:80" -t oracle/oud:11123 .