#!/usr/bin/env bash

echo ">>> Installing NodeJS"

NODEJS_VERSION=$1

curl --silent --location https://deb.nodesource.com/setup_$NODEJS_VERSION | bash -

apt-get update

apt-get install -y nodejs
/usr/bin/npm install -g gulp
/usr/bin/npm install -g yarn
