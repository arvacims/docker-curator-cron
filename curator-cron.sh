#!/bin/sh

PERIOD=${CURATOR_PERIOD:-'daily'}
KEEP_DAYS=${CURATOR_KEEP_DAYS:-'14'}
INDEX_PREFIX=${CURATOR_INDEX_PREFIX:-'fluentd'}
ELASTIC_HOST=${CURATOR_ELASTIC_HOST:-'elasticsearch'}
ELASTIC_PORT=${CURATOR_ELASTIC_PORT:-'9200'}

mkdir -p /etc/periodic/${PERIOD}

CURATOR_SCRIPT="/etc/periodic/${PERIOD}/0-curator"

cat > ${CURATOR_SCRIPT} <<EOF
#!/bin/sh
/usr/bin/curator_cli \
    --host ${ELASTIC_HOST} \
    --port ${ELASTIC_PORT} \
    delete_indices \
    --ignore_empty_list \
    --filter_list '[{"filtertype":"age","source":"name","direction":"older","unit":"days","unit_count":${KEEP_DAYS},"timestring":"%Y%m%d"},{"filtertype":"pattern","kind":"prefix","value":"${INDEX_PREFIX}"}]'
EOF
chmod +x ${CURATOR_SCRIPT}

echo "cron: ${CURATOR_SCRIPT}"
exec crond -f
