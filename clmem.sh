#!/bin/bash

if ! [ -f /etc/clmem.conf ]; then
    echo "Couldn't find /etc/clmem.conf. Daemon will be stopped.";
    exit 1;
fi

# shellcheck disable=SC1091
source /etc/clmem.conf

if [ -z "${CLEAN_TIME}" ]; then
    echo "Couldn't resolve CLEAN_TIME in /etc/clmem.conf. Daemon will be stopped.";
    exit 1;
fi

while true; do
    sync;
    echo 1 > /proc/sys/vm/drop_caches;
    sleep "${CLEAN_TIME}"m;
done