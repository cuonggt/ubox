#!/usr/bin/env bash

echo ">>> Installing Supervisord"

# Install Supervisord
apt-get install -qq supervisor

systemctl enable supervisor.service
service supervisor start
