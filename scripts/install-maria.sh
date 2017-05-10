#!/usr/bin/env bash

if [ -z $1 ]
then
    echo 'Error: missing root password.'
    echo 'Usage: '
    echo '  bash install-maria.sh password'
    exit 0
fi

echo '>>> Installing MariaDB'

# Check If Maria Has Been Installed
if [ -f /home/vagrant/.maria ]
then
    echo 'MariaDB already installed.'
    exit 0
fi

touch /home/vagrant/.maria

MARIADB_VERSION='10.1'
MARIADB_PASSWORD=$1

# Remove MySQL
apt-get remove -y --purge mysql-server mysql-client mysql-common
apt-get autoremove -y
apt-get autoclean

rm -rf /var/lib/mysql
rm -rf /var/log/mysql
rm -rf /etc/mysql

# Add Maria PPA
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
add-apt-repository "deb [arch=amd64,i386,ppc64el] http://nyc2.mirrors.digitalocean.com/mariadb/repo/$MARIADB_VERSION/ubuntu xenial main"
apt-get update

# Install MariaDB without password prompt
# Set username to 'root' and password to 'mariadb_root_password' (see Vagrantfile)
debconf-set-selections <<< "maria-db-$MARIADB_VERSION mysql-server/root_password password $MARIADB_PASSWORD"
debconf-set-selections <<< "maria-db-$MARIADB_VERSION mysql-server/root_password_again password $MARIADB_PASSWORD"

# Install MariaDB
apt-get install -qq mariadb-server

# Configure Password Expiration
echo 'default_password_lifetime = 0' >> /etc/mysql/my.cnf

# Configure Maria Remote Access
sed -i '/^bind-address/s/bind-address.*=.*/bind-address = 0.0.0.0/' /etc/mysql/my.cnf

mysql --user="root" --password="$MARIADB_PASSWORD" -e "GRANT ALL ON *.* TO root@'0.0.0.0' IDENTIFIED BY '$MARIADB_PASSWORD' WITH GRANT OPTION;"
mysql --user="root" --password="$MARIADB_PASSWORD" -e "FLUSH PRIVILEGES;"
service mysql restart
