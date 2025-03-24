ARG NETBOX_VERSION=latest

FROM netboxcommunity/netbox:${NETBOX_VERSION}

RUN <<EOF
apt-get update
apt-get install -y postgresql-client
/opt/netbox/venv/bin/pip install --upgrade pip
EOF

COPY entrypoint.sh /opt/entrypoint.sh
ENTRYPOINT ["/opt/entrypoint.sh"]
