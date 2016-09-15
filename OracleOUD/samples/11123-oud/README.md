##Building OUD Docker Instance Images

IMPORTANT: You have to build the OUD Install Image before this.

The resulting images will have an instance pre-configured. A set of sample data also will be available.

In order to build the instance image execute **build.sh** file or run the below docker build command.

docker build --force-rm=true --no-cache=true --build-arg="http_proxy=http://www-proxy.us.oracle.com:80" -t sampleoud:11123 .

##OUD Docker Run 

IMPORTANT: You have to build the OUD Instance Image before this.

docker run -d -p <non ssl port>:1389 -p <ssl port>:1636 --name oud_ldap sampleoud:11123 startOUD.sh