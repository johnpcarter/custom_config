#!/bin/sh

echo "Stopped webMethods components......"

USER=`id -u -n`

if [ $USER == 'sagadmin' ]
then
	/opt/softwareag/IntegrationServer/instances/default/bin/shutdown.sh
	echo "Goodbye"
else
	su sagadmin -c '/opt/softwareag/IntegrationServer/instances/default/bin/shutdown.sh'
	echo "Goodbye"
fi