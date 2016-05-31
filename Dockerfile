FROM docker-registry.eyeosbcn.com/alpine6-node-base

ENV NginxCwd /etc/nginx
ENV WHATAMI proxy

EXPOSE 443 80

CMD /var/service/start.sh

RUN apk update && apk add nginx && rm -fr /etc/ssl /var/cache/apk/* /tmp/* && \
    chown -R nginx /var/lib/nginx && \
    npm install -g eyeos-service-ready-notify-cli && \
    npm cache clear

COPY certificate/* ${NginxCwd}/certificate/
COPY services /etc/eyeos-services/
COPY statics /etc/eyeos-statics/
COPY nginx.conf ${NginxCwd}/nginx.conf
COPY start.sh /var/service/start.sh
COPY package.json /var/service/

VOLUME ${NginxCwd}/certificate

RUN chmod +x /var/service/start.sh
