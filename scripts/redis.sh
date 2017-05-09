#!/usr/bin/env bash

echo ">>> Installing Redis"

# Install Redis
apt-add-repository ppa:chris-lea/redis-server -y

apt-get update

apt-get install -qq redis-server
