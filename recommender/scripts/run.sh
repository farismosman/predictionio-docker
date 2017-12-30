#!/bin/bash
set -e

cp /etc/config/predictionio/pio-env.sh ${PIO_HOME}/conf/pio-env.sh
cp /etc/config/predictionio/eventserver ${PIO_HOME}/bin/eventserver

cp /etc/config/hbase/hbase-site.xml /usr/local/hbase/conf/
cp /etc/config/hadoop/core-site.xml /usr/local/hadoop/etc/hadoop/

# Change files permissions
chmod +x ${PIO_HOME}/bin/eventserver
chmod +x ${PIO_HOME}/conf/pio-env.sh

${PIO_HOME}/bin/eventserver
yes YES | pio app delete urengine || true
pio app new urengine --access-key "CQJUnXQmIMTHh"
pio build --verbose
