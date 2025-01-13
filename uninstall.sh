#!/usr/bin/bash

if [ "${EUID}" -ne 0 ]; then
    echo "Error: Script can start only by root user";
    exit 1;
fi

function removeError() {
    echo "Error: couldn't remove '${1}' file";
    exit 1;
}

systemctl stop clmem > /dev/null 2>&1

if ! rm /usr/bin/clmem > /dev/null 2>&1; then
    removeError clmem;
fi

if ! rm /etc/clmem.conf > /dev/null 2>&1; then
    removeError clmem.conf;
fi

if ! rm /etc/systemd/system/clmem.service > /dev/null 2>&1; then
    removeError clmem.service;
fi

systemctl daemon-reload > /dev/null 2>&1

echo "Uninstall was successful"
exit 0