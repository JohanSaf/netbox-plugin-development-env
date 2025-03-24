ARG NETBOX_VERSION=latest

FROM netboxcommunity/netbox:${NETBOX_VERSION}

RUN <<EOF
apt-get update
apt-get install -y postgresql-client
if ! type "/usr/local/bin/uv" > /dev/null; then
  /opt/netbox/venv/bin/pip install uv
  UV_PATH="/opt/netbox/venv/bin/uv"
else
  UV_PATH="/usr/local/bin/uv"
fi
find / -name *uv*
${UV_PATH} pip install --upgrade pip
EOF

COPY entrypoint.sh /opt/entrypoint.sh
ENTRYPOINT ["/opt/entrypoint.sh"]
