## script to allow min max JVM memory to be set in custom_wrapper.config prior to setup

The following scripts when added to a webMethods Integration Server will allow you to set the
runtime's min and max memory via the environment variables JAVA_MIN_MEM and JAVA_MAX_MEM.
This is extremely useful when running as a container as it allows a single immutable image to 
be used without customisation.

### SETUP

Edit the docker file to replace the FROM image with your base image where you have installed your Integration Server.
Then Run the Dockerfile to add the scripts to it. Your base image must be a licensed webMethods Integration Server installed 
into /opt/softwareag and running under the sagadmin user

If not, then update the docker-init.sh script accordingly.

### NOTE

This script is not required by webMethods Microservice Runtime as it supports natively the
environment variables JAVA_MIN_MEM and JAVA_MAX_MEM

The script does NOT validate that you have configured the environment variables correctly and if so
your container will not start properly.
