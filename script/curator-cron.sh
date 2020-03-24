#!/bin/sh

PERIOD=${CRON_PERIOD:-'daily'}

mkdir -p /etc/periodic/${PERIOD}

CURATOR_SCRIPT="/etc/periodic/${PERIOD}/0-curator"

cat > ${CURATOR_SCRIPT} <<EOF
#!/bin/sh
/usr/bin/curator --config /curator/curator.yml ${CURATOR_OPTIONS} /curator/actions.yml
EOF
chmod +x ${CURATOR_SCRIPT}

echo "cron: ${CURATOR_SCRIPT}"
exec crond -f