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
apt-get -y install build-essential php7.2
apt-get install php7.2-apcu
apt-get install php7.2-curl
apt-get install php7.2-gd
apt-get install php7.2-imap
apt-get install php7.2-intl
apt-get install php7.2-ldap
apt-get install php7.2-mbstring
apt-get install php7.2-mysql
apt-get install php7.2-pspell
apt-get install php7.2-recode
apt-get install php7.2-tidy
apt-get install php7.2-xmlrpc
apt-get install php7.2-xsl
apt-get install php-cas
apt-get install php-gettext
apt-get install php-imagick
apt-get install php-memcache
apt-get install php-pear
apt-get install libapache2-mod-php7.2

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
