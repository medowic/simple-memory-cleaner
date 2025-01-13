#!/usr/bin/bash

if [ "${EUID}" -ne 0 ]; then
    echo "Error: Script can start only by root user";
    exit 1;
fi

function downloadError() {
    echo "Error: couldn't download '${1}' file from GitHub";
    echo "Possible solutions:";
    echo " - check your Internet connection";
    echo " - is there 'curl' installed on your machine";
    echo " - have you permissions to /usr/bin/";
    echo "And try again";
    exit 1;
}

if ! curl https://raw.githubusercontent.com/medowic/simple-memory-cleaner/master/clmem.sh -o /usr/bin/clmem > /dev/null 2>&1; then
    downloadError clmem.sh;
else
    chmod 755 /usr/bin/clmem;
    chmod +x /usr/bin/clmem;
fi

if ! curl https://raw.githubusercontent.com/medowic/simple-memory-cleaner/master/clmem.conf -o /etc/clmem.conf > /dev/null 2>&1; then
    downloadError clmem.conf;
fi

if ! curl https://raw.githubusercontent.com/medowic/simple-memory-cleaner/master/clmem.service -o /etc/systemd/system/clmem.service > /dev/null 2>&1; then
    downloadError clmem.service;
fi

systemctl daemon-reload > /dev/null 2>&1
systemctl start clmem > /dev/null 2>&1 
systemctl enable clmem > /dev/null 2>&1

echo "Simple Memory Cleaner was installed"
echo "You can use it by run 'clmem' and start/stop daemon by 'systemctl stop clmem'"
exit 0;