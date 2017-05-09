#!/usr/bin/env bash

echo ">>> Cleaning up"

# Clean Up
apt-get -y autoremove
apt-get -y clean

# Enable Swap Memory
/bin/dd if=/dev/zero of=/var/swap.1 bs=1M count=1024
/sbin/mkswap /var/swap.1
/sbin/swapon /var/swap.1

# Minimize The Disk Image
echo "Minimizing disk image..."
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
sync
