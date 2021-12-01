#!/bin/sh
#
#

status=`curl -s -o /dev/null -w "%{http_code}" localhost:5555/invoke/wm.server/ping`

cmdret=$?
if [[ $cmdret != 0 || "$status" != "200" ]]
then
  exit 1
else
  exit 0
fi
