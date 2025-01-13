#!/usr/bin/bash

if [ "${EUID}" -ne 0 ]; then
    echo "Error: Script can start only by root user";
    exit 1;
fi

function cleanMemory() {
    sync;
    echo 1 > /proc/sys/vm/drop_caches;
}

if [ "${1}" == "--systemd" ]; then
    if ! [ -f /etc/clmem.conf ]; then
        echo "Warning: Couldn't find '/etc/clmem.conf'. Daemon will be cleaning memory every 30 minutes";
        echo "Note: In /etc/clmem.conf file was added 'CLEAN_TIME' setting";
        echo "CLEAN_TIME=30" | tee /etc/clmem.conf > /dev/null;
        CLEAN_TIME=30;
    else
        # shellcheck disable=SC1091
        source /etc/clmem.conf
        if [ -z "${CLEAN_TIME}" ]; then
            echo "Warning: Couldn't resolve values from '/etc/clmem.conf'. Daemon will be cleaning memory every 30 minutes";
            echo "Note: In /etc/clmem.conf file was added 'CLEAN_TIME' setting";
            echo "CLEAN_TIME=30" | tee /etc/clmem.conf > /dev/null;
            CLEAN_TIME=30;
        elif [ "${CLEAN_TIME}" -lt 1 ]; then
            echo "Error: 'CLEAN_TIME' value in '/etc/clmem' is less than 1, so daemon was stopped"
            exit 1;
        fi
    fi

    while true; do
        cleanMemory;
        sleep "${CLEAN_TIME}"m;
    done
else
    MEM_BEFORE=$(free | sed "2q;d" | awk '{print $6}')
    cleanMemory;
    MEM_AFTER=$(free | sed "2q;d" | awk '{print $6}')
    echo "Cleaned: $(((MEM_BEFORE - MEM_AFTER) / 1024)) MiB"
    exit 0;
fi