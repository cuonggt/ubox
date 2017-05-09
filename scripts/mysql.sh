#!/usr/bin/env bash

MYSQL_VERSION=$1
MYSQL_PASSWORD=$2

echo ">>> Installing MySQL Server $MYSQL_VERSION"

# Install MySQL
debconf-set-selections <<< "mysql-server mysql-server/root_password password $MYSQL_PASSWORD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $MYSQL_PASSWORD"

if [ $MYSQL_VERSION == "5.6" ]; then
    add-apt-repository -y ppa:ondrej/mysql-5.6

    apt-get update

    package=mysql-server-5.6
else
    package=mysql-server
fi

apt-get install -y $package

# Configure MySQL Password Lifetime
echo "default_password_lifetime = 0" >> /etc/mysql/mysql.conf.d/mysqld.cnf

# Configure MySQL Remote Access
sed -i "s/bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/mysql.conf.d/mysqld.cnf

mysql --user="root" --password="$MYSQL_PASSWORD" -e "GRANT ALL ON *.* TO root@'0.0.0.0' IDENTIFIED BY '$MYSQL_PASSWORD' WITH GRANT OPTION;"
mysql --user="root" --password="$MYSQL_PASSWORD" -e "FLUSH PRIVILEGES;"

# Add Timezone Support To MySQL
mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql --user=root --password=$MYSQL_PASSWORD mysql

service mysql restart
