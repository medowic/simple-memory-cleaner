#!/bin/bash

if [ "${EUID}" -ne 0 ]; then
    echo "";
    echo "Script can start only by root user";
    echo "";
    exit 1;
fi

mkdir /root/.clmem

curl https://raw.githubusercontent.com/medowic/simple-memory-cleaner/master/clmem.sh -o /root/.clmem/clmem.sh >/dev/null 2>&1
curl https://raw.githubusercontent.com/medowic/simple-memory-cleaner/master/clmem.conf -o /etc/clmem.conf >/dev/null 2>&1
curl https://raw.githubusercontent.com/medowic/simple-memory-cleaner/master/clmem.service -o /etc/systemd/system/clmem.service >/dev/null 2>&1

systemctl daemon-reload >/dev/null 2>&1
systemctl start clmem >/dev/null 2>&1 
systemctl enable clmem >/dev/null 2>&1

echo ""
echo "Simple-Memory-Cleaner setup was successful. Memory cleaner can be stopped by 'systemctl stop clmem'"
echo ""
exit 0