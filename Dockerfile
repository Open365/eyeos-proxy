FROM docker-registry.eyeosbcn.com/alpine6-node-base

ENV WHATAMI proxy

EXPOSE 443 80

CMD /tmp/start.sh

RUN apk update && apk add nginx && rm -fr /etc/ssl /var/cache/apk/* /tmp/*

COPY certificate/* ${NginxCwd}/certificate/
COPY services /etc/eyeos-services/
COPY statics /etc/eyeos-statics/
COPY nginx.conf ${NginxCwd}/nginx.conf
COPY start.sh /tmp/start.sh
COPY package.json /var/service/

VOLUME ${NginxCwd}/certificate

RUN chmod +x /tmp/start.sh
