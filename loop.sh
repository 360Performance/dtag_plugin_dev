#!/bin/bash 
DIR="/var/lib/dynatrace/packages"
while [ ! -d "$DIR" ]; do
    echo "waiting for packages directory to be created by AG installer ..."
    sleep 1
done
while [ -d "$DIR" ]; do
    touch /var/lib/dynatrace/packages/modules.downloaded
    sleep 1
done