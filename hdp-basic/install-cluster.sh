#!/bin/bash

CLUSTER='hdp-basic'
HOST='n1.hdp'
AMBARI_HOST=$HOST
AMBARI_USER='admin'
AMBARI_USER_PASSWORD='admin'

while [ -z "$(netstat -tulpn | grep 8080)" ]; do
  ambari-server start
  ambari-agent start
  sleep 20
done

java -jar /tmp/ambari-shell.jar --ambari.host=$HOST << EOF
blueprint add --file /tmp/blueprint.json
cluster build --blueprint hdp-basic
cluster assign --hostGroup host_group_1 --host $HOST
cluster create --exitOnFinish true
EOF
#cluster assign --hostGroup host_group_1 --host $(hostname -f)
#cluster autoAssign   

sleep 60
