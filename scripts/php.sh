#!/usr/bin/env bash

PHP_VERSION=$1

echo ">>> Installing PHP $PHP_VERSION"

# Install PPA
add-apt-repository -y ppa:ondrej/php

apt-get update

# Install PHP Stuffs
apt-get install -qq php${PHP_VERSION}-cli php${PHP_VERSION}-fpm php${PHP_VERSION}-dev \
php${PHP_VERSION}-mysql php${PHP_VERSION}-pgsql php${PHP_VERSION}-sqlite3 php${PHP_VERSION}-gd \
php${PHP_VERSION}-curl php${PHP_VERSION}-gmp php${PHP_VERSION}-mcrypt php${PHP_VERSION}-memcached \
php${PHP_VERSION}-imagick php${PHP_VERSION}-imap php${PHP_VERSION}-mbstring \
php${PHP_VERSION}-xml php${PHP_VERSION}-zip php${PHP_VERSION}-bcmath php${PHP_VERSION}-soap \
php${PHP_VERSION}-intl php${PHP_VERSION}-readline php-xdebug

# Install Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# Add Composer Global Bin To Path
printf "\nPATH=\"$(sudo su - vagrant -c 'composer config -g home 2>/dev/null')/vendor/bin:\$PATH\"\n" | tee -a /home/vagrant/.profile

# Set Some PHP CLI Settings
sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/${PHP_VERSION}/cli/php.ini
sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php/${PHP_VERSION}/cli/php.ini
sudo sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/${PHP_VERSION}/cli/php.ini
sudo sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/${PHP_VERSION}/cli/php.ini

# Setup Some PHP-FPM Options
echo "xdebug.remote_enable = 1" >> /etc/php/${PHP_VERSION}/mods-available/xdebug.ini
echo "xdebug.remote_connect_back = 1" >> /etc/php/${PHP_VERSION}/mods-available/xdebug.ini
echo "xdebug.remote_port = 9000" >> /etc/php/${PHP_VERSION}/mods-available/xdebug.ini
echo "xdebug.max_nesting_level = 512" >> /etc/php/${PHP_VERSION}/mods-available/xdebug.ini
echo "opcache.revalidate_freq = 0" >> /etc/php/${PHP_VERSION}/mods-available/opcache.ini

sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/${PHP_VERSION}/fpm/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php/${PHP_VERSION}/fpm/php.ini
sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/${PHP_VERSION}/fpm/php.ini
sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/${PHP_VERSION}/fpm/php.ini
sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /etc/php/${PHP_VERSION}/fpm/php.ini
sed -i "s/post_max_size = .*/post_max_size = 100M/" /etc/php/${PHP_VERSION}/fpm/php.ini
sed -i "s/;date.timezone.*/date.timezone = UTC/" /etc/php/${PHP_VERSION}/fpm/php.ini

# Disable XDebug On The CLI
sudo phpdismod -s cli xdebug

# Set The PHP-FPM User
sed -i "s/user = www-data/user = vagrant/" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf
sed -i "s/group = www-data/group = vagrant/" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf

sed -i "s/listen\.owner.*/listen.owner = vagrant/" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf
sed -i "s/listen\.group.*/listen.group = vagrant/" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf
sed -i "s/;listen\.mode.*/listen.mode = 0666/" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf

service php${PHP_VERSION}-fpm restart
