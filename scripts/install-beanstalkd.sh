#!/usr/bin/env bash

echo ">>> Installing Beanstalkd"

# Install Beanstalkd
apt-get install -y beanstalkd

# Configure Beanstalkd
sed -i "s/#START=yes/START=yes/" /etc/default/beanstalkd
/etc/init.d/beanstalkd start
