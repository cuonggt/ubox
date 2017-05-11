#!/usr/bin/env bash

DB_DATABASE=$1
DB_USERNAME=$2
DB_PASSWORD=$3

cat > /root/.my.cnf << EOF
[client]
user = $DB_USERNAME
password = $DB_PASSWORD
host = localhost
EOF

cp /root/.my.cnf /home/vagrant/.my.cnf

mysql -e "CREATE DATABASE IF NOT EXISTS \`$DB_DATABASE\` DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_unicode_ci";
