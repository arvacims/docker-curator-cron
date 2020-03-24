FROM alpine:3.11

ENV CURATOR_OPTIONS ""
ENV CURATOR_VERSION 5.8.1

RUN apk add --no-cache python3 && \
        python3 -m ensurepip && \
        rm -r /usr/lib/python*/ensurepip && \
        pip3 install --no-cache --upgrade pip setuptools wheel && \
        pip install elasticsearch-curator==${CURATOR_VERSION}

COPY config/config.yml /curator/curator.yml
COPY actions/actions.yml /curator/actions.yml

COPY script/curator-cron.sh /usr/bin/curator-cron.sh
RUN chmod +x /usr/bin/curator-cron.sh

CMD ["/usr/bin/curator-cron.sh"]
