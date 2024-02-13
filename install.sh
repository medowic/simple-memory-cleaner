#!/bin/bash

if [ "${EUID}" -ne 0 ]; then
    echo "";
    echo "Script can start only by root user";
    echo "";
    exit 1;
fi

mkdir /root/.clmem

echo "[Unit]
Description=Simple Memory Cleaner (ClMem) Service
After=network.target
[Service]
User=root
Group=root
ExecStart=/usr/bin/bash /root/.clmem/clmem.sh
[Install]
WantedBy=multi-user.target
" | tee /etc/systemd/system/clmem.service >/dev/null 2>&1

echo "#!/bin/bash

while true; do
    sync; echo 1 > /proc/sys/vm/drop_caches
    sleep 30m
done
" | tee /root/.clmem/clmem.sh >/dev/null 2>&1

systemctl daemon-reload >/dev/null 2>&1
systemctl start clmem >/dev/null 2>&1 
systemctl enable clmem >/dev/null 2>&1

echo ""
echo "Simple-Memory-Cleaner setup was successful. Memory cleaner can be stopped by 'systemctl stop clmem'"
echo ""
exit 0