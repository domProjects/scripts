#!/bin/bash

# Sources
#
# https://github.com/PluginsOCSInventory-NG

#

#
clear

# update apt
apt-get clean
apt-get -y update
apt-get -y upgrade
apt-get -y dist-upgrade

# add repository
add-apt-repository universe

# Install prereqs
apt-get -y install build-essential
apt-get -y install cpanminus
apt-get -y install make gcc

#
apt-get -y install apache2
systemctl enable apache2
systemctl start apache2








