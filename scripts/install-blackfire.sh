#!/usr/bin/env bash

echo ">>> Installing Blackfire"

# Install Blackfire
curl -s https://packagecloud.io/gpg.key | apt-key add -
echo "deb http://packages.blackfire.io/debian any main" | tee /etc/apt/sources.list.d/blackfire.list
apt-get update

apt-get install -qq blackfire-agent blackfire-php
