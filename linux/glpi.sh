#!/bin/bash

# glpi
glpiversion="9.3.2"
pluginglpiocsversion="1.5.4"

ocsteamviewer="1.1"
ocsnetworkshare="1.0"
ocsofficepack="2.0"
ocssecurity="1.1"

#
clear

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
#systemctl enable apache2
#systemctl start apache2

#
apt-get -y install build-essential
apt-get -y install php7.2
apt-get -y install php7.2-apcu
apt-get -y install php7.2-curl
apt-get -y install php7.2-gd
apt-get -y install php7.2-imap
apt-get -y install php7.2-intl
apt-get -y install php7.2-ldap
apt-get -y install php7.2-mbstring
apt-get -y install php7.2-mysql
apt-get -y install php7.2-pspell
apt-get -y install php7.2-recode
apt-get -y install php7.2-tidy
apt-get -y install php7.2-xmlrpc
apt-get -y install php7.2-xsl
apt-get -y install php-cas
apt-get -y install php-gettext
apt-get -y install php-imagick
apt-get -y install php-memcache
apt-get -y install php-pear
apt-get -y install libapache2-mod-php7.2

# install data base
#apt-get -y install mysql-server
#apt-get -y install phpmyadmin

#
cd /tmp/

#
wget -O glpi-ocsinventoryng-${pluginglpiocsversion}.tar.gz https://github.com/pluginsGLPI/ocsinventoryng/releases/download/${pluginglpiocsversion}/glpi-ocsinventoryng-${pluginglpiocsversion}.tar.gz

if [ $? -ne 0 ]; then
  echo "Failed to download glpi-ocsinventoryng-${pluginglpiocsversion}.tar.gz"
  echo "https://github.com/pluginsGLPI/ocsinventoryng/releases/download/${pluginglpiocsversion}/glpi-ocsinventoryng-${pluginglpiocsversion}.tar.gz"
  exit
fi

tar -xvf glpi-ocsinventoryng-${pluginglpiocsversion}.tar.gz
mv ocsinventoryng /var/www/html/glpi/plugins/



#
cd /tmp/

#
wget -O teamviewer.zip https://github.com/PluginsOCSInventory-NG/teamviewer/releases/download/${ocsteamviewer}/teamviewer.zip
if [ $? -ne 0 ]; then
    echo "Failed to download teamviewer.zip"
    echo "https://github.com/PluginsOCSInventory-NG/teamviewer/releases/download/${ocsteamviewer}/teamviewer.zip"
    exit
fi
mv teamviewer.zip /usr/share/ocsinventory-reports/ocsreports/download/

#
wget -O networkshare.zip https://github.com/PluginsOCSInventory-NG/networkshare/releases/download/${ocsnetworkshare}/networkshare.zip
if [ $? -ne 0 ]; then
    echo "Failed to download networkshare.zip"
    echo "https://github.com/PluginsOCSInventory-NG/networkshare/releases/download/${ocsnetworkshare}/networkshare.zip"
    exit
fi
mv networkshare.zip /usr/share/ocsinventory-reports/ocsreports/download/

#
wget -O officepack.zip https://github.com/PluginsOCSInventory-NG/officepack/releases/download/${ocsofficepack}/officepack.zip
if [ $? -ne 0 ]; then
    echo "Failed to download officepack.zip"
    echo "https://github.com/PluginsOCSInventory-NG/officepack/releases/download/${ocsofficepack}/officepack.zip"
    exit
fi
mv officepack.zip /usr/share/ocsinventory-reports/ocsreports/download/

#
wget -O security.zip https://github.com/PluginsOCSInventory-NG/security/releases/download/${ocssecurity}/security.zip
if [ $? -ne 0 ]; then
    echo "Failed to download security.zip"
    echo "https://github.com/PluginsOCSInventory-NG/security/releases/download/${ocssecurity}/security.zip"
    exit
fi
mv security.zip /usr/share/ocsinventory-reports/ocsreports/download/



# clean install
rm -rf /tmp/*
rm -rf ./glpi.sh*
