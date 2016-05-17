################################################################################
## Dockerfile for the EyeOS Proxy ##############################################
################################################################################

FROM docker-registry.eyeosbcn.com/eyeos-fedora21-node-base

ENV NginxCwd /etc/nginx
ENV WHATAMI proxy

RUN yum install nginx httpd haproxy -y \
    && yum clean all \
    && rm -rf /etc/nginx/sites-enabled \
    && rm -rf /etc/nginx/conf.d/* \
    && rm -rf /usr/share/nginx/html/* \
    && npm install -g eyeos-service-ready-notify-cli \
    && npm cache clean
EXPOSE 443 80 5600

CMD /tmp/start.sh

COPY certificate/*.crt ${NginxCwd}/certificate/
COPY certificate/*.key ${NginxCwd}/certificate/
COPY certificate/haproxy.pem /etc/ssl/haproxy.pem
COPY services /etc/eyeos-services/
COPY statics /etc/eyeos-statics/
COPY nginx.conf ${NginxCwd}/nginx.conf
COPY haproxy.conf /etc/haproxy/haproxy.cfg
COPY start.sh /tmp/start.sh
COPY package.json /var/service/

VOLUME ${NginxCwd}/certificate

RUN chmod +x /tmp/start.sh
