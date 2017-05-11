#!/usr/bin/env bash

DB_DATABASE=$1
DB_USERNAME=$2
DB_PASSWORD=$3

mongo admin --eval "db.createUser({user:'$DB_USERNAME',pwd:'$DB_PASSWORD',roles:['root']})"
mongo $DB_DATABASE --eval "db.test.insert({name:'db creation'})"
sudo service mongod restart
