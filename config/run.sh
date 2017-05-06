#!/bin/sh
set -e

# Copy config to shared volume
cp -rf /tmp/* /etc/config/

/bin/sh
