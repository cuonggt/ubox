#!/usr/bin/env bash

echo ">>> Clear The Old Nginx Sites"

# Clear The Old Nginx Sites
rm -f /etc/nginx/sites-enabled/*
rm -f /etc/nginx/sites-available/*
