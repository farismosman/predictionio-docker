#!/bin/bash
set -e

# ====== Hack begins =======
#This is a hack until we fix spark-submit in pio
#to pass elasticsearch hostname correctly

ES_IP=$(dig +short espio)
echo "Elasticsearch IP address: " ${ES_IP}
cp /etc/hosts /hosts && sed -i "s/127.0.0.1/${ES_IP}/g" /hosts
cp -f /hosts /etc/hosts
# ====== Hack ends =======

# $1 is either master or slave
/usr/bin/supervisord --configuration=/opt/spark/conf/$1.conf
