#!/bin/bash
mkdir -p /mnt/eyeosFS
mkdir -p /mnt/rawFS/eyeos
sed -i "s/.*\bworker_processes\b.*/worker_processes ${NGINX_WORKERS};/" /etc/nginx/nginx.conf
eyeos-service-ready-notify-cli &
eyeos-run-server --serf --gateway-resolver nginx
