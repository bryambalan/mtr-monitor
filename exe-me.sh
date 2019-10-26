#!/bin/bash

IDENTITY=`whoami`

if ! [ $IDENTITY == 'root' ]
then
    printf "Voce e root?\n.\n.\n.\n."
    exit
fi

echo ================= Movendo arquivos =====================

mkdir /opt/mtr-monitor
cp -r  * /opt/mtr-monitor/
chmod a+x /opt/mtr-monitor/*

echo ================== Criado service =======================

echo "[Unit]" > /etc/systemd/system/mtr-monitor.service
echo "Description=MTR-Monitor Cabelo Made4it" >> /etc/systemd/system/mtr-monitor.service
echo "[Service]" >> /etc/systemd/system/mtr-monitor.service
echo "Type=simple" >> /etc/systemd/system/mtr-monitor.service
echo "ExecStart=/opt/mtr-monitor/mtr-monitor.sh" >> /etc/systemd/system/mtr-monitor.service
echo "Restart=on-abort" >> /etc/systemd/system/mtr-monitor.service
echo "[Install]" >> /etc/systemd/system/mtr-monitor.service
echo "WantedBy=multi-user.target" >> /etc/systemd/system/mtr-monitor.service
chmod +x /etc/systemd/system/mtr-monitor.service
systemctl enable mtr-monitor.service
systemctl start mtr-monitor.service
systemctl status mtr-monitor.service
