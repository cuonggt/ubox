#!/usr/bin/env bash

if [[ -z "$1" || -z "$2" || -z "$3" || -z "$4" ]]
then
    echo "Error: missing required parameters."
    echo "Usage: "
    echo "  sudo bash serve-blackfire.sh server-id server-token client-id client-token"
    exit 0
fi

PHP_VERSION="7.1"

agent="[blackfire]
ca-cert=
collector=https://blackfire.io
log-file=stderr
log-level=1
server-id="$1"
server-token="$2"
socket=unix:///var/run/blackfire/agent.sock
spec=
"

client="[blackfire]
ca-cert=
client-id="$3"
client-token="$4"
endpoint=https://blackfire.io
timeout=15s
"

echo "$agent" > "/etc/blackfire/agent"
echo "$client" > "/home/vagrant/.blackfire.ini"

service php$PHP_VERSION-fpm restart
service blackfire-agent restart
