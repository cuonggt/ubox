#!/usr/bin/env bash

echo ">>> Installing PostgreSQL"

PQSQL_VERSION=9.5
PQSQL_PASSWORD=$1

# Install Postgres
apt-get install -qq postgresql

# Configure Postgres Remote Access
sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" /etc/postgresql/$PQSQL_VERSION/main/postgresql.conf
echo "host    all             all             0.0.0.0/0               md5" | tee -a /etc/postgresql/$PQSQL_VERSION/main/pg_hba.conf
sudo -u postgres psql -c "CREATE ROLE root LOGIN UNENCRYPTED PASSWORD '$PQSQL_PASSWORD' SUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION;"

# Configure The Timezone
sed -i "s/localtime/UTC/" /etc/postgresql/$PQSQL_VERSION/main/postgresql.conf

service postgresql restart
