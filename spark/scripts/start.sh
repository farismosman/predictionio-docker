#!/bin/bash
set -e

# $1 is either master or slave
/usr/bin/supervisord --configuration=/opt/spark/conf/$1.conf
