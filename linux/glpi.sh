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
apt-get -y install build-essential php
apt-get install php-apcu
apt-get install php-cas
apt-get install php-curl
apt-get install php-gd
apt-get install php-gettext
apt-get install php-imagick
apt-get install php-imap
apt-get install php-intl
apt-get install php-ldap
apt-get install php-mbstring
apt-get install php-memcache
apt-get install php-mysql
apt-get install php-pear
apt-get install php-pspell
apt-get install php-recode
apt-get install php-tidy
apt-get install php-xmlrpc
apt-get install php-xsl
apt-get install libapache2-mod-php

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
