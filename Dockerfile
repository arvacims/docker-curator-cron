FROM alpine:3.11

ENV CURATOR_OPTIONS ""
ENV CURATOR_VERSION 5.8.1

RUN apk add --no-cache python3 \
    && python3 -m ensurepip \
    && rm -r /usr/lib/python*/ensurepip \
    && pip3 install --no-cache-dir --upgrade pip setuptools wheel \
    && pip3 install --no-cache-dir --upgrade elasticsearch-curator==${CURATOR_VERSION}

COPY assets/config.yml      /curator/curator.yml
COPY assets/actions.yml     /curator/actions.yml
COPY assets/curator-cron.sh /usr/bin/curator-cron.sh

RUN chmod +x /usr/bin/curator-cron.sh

CMD ["/usr/bin/curator-cron.sh"]
