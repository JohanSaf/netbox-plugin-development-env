ARG NETBOX_VERSION=latest

FROM netboxcommunity/netbox:${NETBOX_VERSION}

RUN <<EOF
apt-get update
apt-get install -y postgres-client
EOF

COPY entrypoint.sh /opt/entrypoint.sh
ENTRYPOINT ["/opt/entrypoint.sh"]
