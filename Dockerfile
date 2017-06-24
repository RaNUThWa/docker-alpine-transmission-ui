FROM alpine:3.6
MAINTAINER Sergey Savchenko <skymlife@yandex.ru>

RUN apk add --update transmission-daemon ca-certificates openssl && \
    update-ca-certificates && rm -rf /var/cache/apk/*

ADD ./start.sh /start.sh
ADD ./settings.example.json /settings.example.json
ADD ./settings.example.json /config/settings.json
ADD ./tr-control-easy-install.sh /tr-control-easy-install.sh

RUN chmod u+x /start.sh && mkdir -p /downloads /watch /config /incomplete && \
    sh tr-control-easy-install.sh

VOLUME ["/downloads", "/incomplete", "/watch", "/config"]

EXPOSE 9091 45555

CMD ["/start.sh"]
