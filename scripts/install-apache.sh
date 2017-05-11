#!/usr/bin/env bash

echo '>>> Installing Apache'

PHP_VERSION=7.1

sudo service nginx stop
sudo add-apt-repository -y ppa:ondrej/apache2
sudo apt-get update
sudo apt-get install -qq apache2 libapache2-mod-php$PHP_VERSION
sudo sed -i "s/www-data/vagrant/" /etc/apache2/envvars
