#!/usr/bin/env bash

echo ">>> Installing NodeJS"

apt-get install -y nodejs
/usr/bin/npm install -g gulp
/usr/bin/npm install -g yarn
