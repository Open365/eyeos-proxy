#!/bin/sh
mkdir -p /mnt/eyeosFS
mkdir -p /mnt/rawFS/eyeos
sed -i "s/.*\bworker_processes\b.*/worker_processes ${NGINX_WORKERS};/" /etc/nginx/nginx.conf

SERVICE_DISCOVERY=${EYEOS_SERVICE_DISCOVERY:-"serf"}
if [ $SERVICE_DISCOVERY != "serf" ];
then
    sed -i "s/gateway/127.0.0.1/" /etc/nginx/nginx.conf
    dnsmasq -k -p 5300 --log-facility=/dnsmasq.log --resolv-file=/open365/resolv.conf &
    eyeos-run-server --gateway-resolver nginx
else
    eyeos-service-ready-notify-cli &
    eyeos-run-server --serf --gateway-resolver nginx
fi

