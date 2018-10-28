#!/bin/bash

# glpi
glpiversion="9.3.2"

# add repository
add-apt-repository universe

# update apt
apt-get clean
apt-get -y update
apt-get -y upgrade
apt-get -y dist-upgrade

# Install prereqs
apt-get -y install make gcc

#
apt-get -y install apache2
systemctl enable apache2
systemctl start apache2

#
apt-get -y build-essential php
apt-get php-apcu
apt-get php-cas
apt-get php-curl
apt-get php-gd
apt-get php-gettext
apt-get php-imagick
apt-get php-imap
apt-get php-intl
apt-get php-ldap
apt-get php-mbstring
apt-get php-memcache
apt-get php-mysql
apt-get php-pear
apt-get php-pspell
apt-get php-recode
apt-get php-tidy
apt-get php-xmlrpc
apt-get php-xsl
apt-get libapache2-mod-php

# install data base
#apt-get -y install mysql-server phpmyadmin

#
#cd /tmp/

#
#wget -O glpi-${glpiversion}.tgz https://github.com/glpi-project/glpi/releases/download/${glpiversion}/glpi-${glpiversion}.tgz

#if [ $? -ne 0 ]; then
  #echo "Failed to download glpi-${glpiversion}.tgz"
  #echo "https://github.com/glpi-project/glpi/releases/download/${glpiversion}/glpi-${glpiversion}.tgz"
  #exit
#fi

#tar -xvf glpi-${glpiversion}.tgz
#mv glpi /var/www/html/
#chmod 755 -R /var/www/html/

# clean folder temp
rm -rf /tmp/*
