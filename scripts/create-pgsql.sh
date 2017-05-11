#!/usr/bin/env bash

DB_DATABASE=$1
DB_USERNAME=$2

# su postgres -c "dropdb $DB_DATABASE --if-exists"

if ! su postgres -c "psql $DB_DATABASE -c '\q' 2>/dev/null"; then
    su postgres -c "createdb -O $DB_USERNAME '$DB_DATABASE'"
fi
