# Based on https://github.com/bianjp/docker-mariadb-alpine

FROM alpine:latest

LABEL vendor="DUzun.Me" \
      application="SphinxSearch" \
      version="1.0.0"

ENV LC_ALL=en_US.UTF-8

RUN apk -U upgrade \
    && apk add sphinx \
    && mkdir -p /etc/sphinx \
    && rm -rf /tmp/src /var/cache/apk/* \
    && rm -rf /var/run && ln -s /run /var/

VOLUME /var/lib/sphinx

COPY scripts/ /usr/local/bin/
COPY etc/ /etc/sphinx/

RUN chmod +x /usr/local/bin/*.sh \
    && chmod +x /etc/sphinx/*.sh \
    && ln -sf /usr/local/bin/docker-start.sh /

CMD ["/docker-start.sh"]

EXPOSE 9306
EXPOSE 9312
