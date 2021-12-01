#!/bin/sh
#
# startup script
#


# Define SIGTERM-handler for graceful shutdown
term_handler() {
  if [ $childPID -ne 0 ]; then
    /bin/bash ./docker-stop.sh
  fi
  exit 143; # 128 + 15 -- SIGTERM
}
# setup SIGTERM Handler
trap 'kill ${!}; term_handler' SIGTERM

# start up components

echo "Starting webMethods components......"

#/opt/sag/profiles/SPM/bin/startup.sh

USER=`id -u -n`

if [ $USER == 'sagadmin' ]
then
  /opt/softwareag/configure-custom-wrapper.sh /opt/softwareag/profiles/IS_default ${JAVA_MIN_MEM} ${JAVA_MAX_MEM}
	/opt/softwareag/IntegrationServer/instances/default/bin/server.sh
else
  su sagadmin -c '/opt/softwareag/configure-custom-wrapper.sh /opt/softwareag/profiles/IS_default ${JAVA_MIN_MEM} ${JAVA_MAX_MEM}' 
	su sagadmin -c '/opt/softwareag/IntegrationServer/instances/default/bin/server.sh'
fi

# keep container running

ALERT_LOG=/opt/softwareag/IntegrationServer/instances/default/logs/server.log

while [ ! -r $ALERT_LOG ]
do
  echo "waiting for server.log to start..."
  sleep 5
done

echo "outputing server.log to stdout...."

tail -f $ALERT_LOG &
childPID=$!
wait $childPID

# end
