#!/usr/bin/env bash

# install required vagrant plugin to handle reloads during provisioning
vagrant plugin install vagrant-reload
vagrant plugin install dotenv

# start with no machines
# vagrant destroy -f
# rm -rf .vagrant

vagrant up
