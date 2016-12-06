#!/bin/bash
set -e
cd /UREngine

pio-start-all
yes YES | pio app delete urengine || true
pio app new urengine --access-key $ACCESS_KEY
pio build --verbose

service rsyslog start
service ssh restart
tail -F /UREngine/pio.log /var/log/syslog
