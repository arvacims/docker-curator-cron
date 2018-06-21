FROM alpine:3.7

ENV CURATOR_VERSION 5.5.4

RUN apk --update add python py-setuptools py-pip \
    && pip install elasticsearch-curator==${CURATOR_VERSION} \
    && apk del py-pip \
    && rm -rf /var/cache/apk/*

COPY curator-cron.sh /usr/bin/curator-cron.sh
RUN chmod +x /usr/bin/curator-cron.sh

CMD ["/usr/bin/curator-cron.sh"]
