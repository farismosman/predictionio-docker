#!/bin/bash
set -e

# Copy config files from the shared location
cp -r /etc/config/spark/*.conf /opt/spark/conf/
cp /etc/config/spark/cleanup.sh /cleanup.sh
chmod +x /cleanup.sh

# $1 is either master or slave
/usr/bin/supervisord --configuration=/opt/spark/conf/$1.conf
