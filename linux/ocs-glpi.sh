#!/bin/bash

# Sources
#
# https://github.com/PluginsOCSInventory-NG

#
ocsversion="2.5"
ocsteamviewer="1.1"
ocsnetworkshare="1.0"
ocsofficepack="2.0"
ocssecurity="1.1"
#
glpiversion="9.3.2"
pluginglpiocsversion="1.5.4"

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

#
apt-get -y install php7.2
apt-get -y install php7.2-apcu
apt-get -y install php7.2-cgi
apt-get -y install php7.2-curl
apt-get -y install php7.2-gd
apt-get -y install php7.2-imap
apt-get -y install php7.2-intl
apt-get -y install php7.2-ldap
apt-get -y install php7.2-mbstring
apt-get -y install php7.2-mysql
apt-get -y install php7.2-pspell
apt-get -y install php7.2-recode
apt-get -y install php7.2-snmp
apt-get -y install php7.2-soap
apt-get -y install php7.2-tidy
apt-get -y install php7.2-xml
apt-get -y install php7.2-xmlrpc
apt-get -y install php7.2-xsl
apt-get -y install php-pear
apt-get -y install php-cas
apt-get -y install php-gettext
apt-get -y install php-imagick
apt-get -y install php-memcache
apt-get -y install perl
apt-get -y install perl-modules
apt-get -y install libapache2-mod-php7.2
apt-get -y install libapache2-mod-perl2
apt-get -y install libcompress-zlib-perl
apt-get -y install libdbd-mysql-perl
apt-get -y install libdbi-perl
apt-get -y install libnet-ip-perl
apt-get -y install libsoap-lite-perl
apt-get -y install libxml-simple-perl

#
cpan -i Apache::DBI
cpan -i Archive::Zip
cpan -i Compress::Zlib
cpan -i DBD::Mysql
cpan -i DBI
cpan -i Mojolicious::Lite
cpan -i Net::IP
cpan -i Plack::Handler
cpan -i Switch
cpan -i XML::Entities
cpan -i XML::Simple
cpan -i YAML

#
apt-get -y install mysql-server
apt-get -y install phpmyadmin

#
echo "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'your_password';"
echo "FLUSH PRIVILEGES;"
echo "exit;"

mysql -u root -p

# Download OCS Inventory Server
wget -O OCSNG_UNIX_SERVER_${ocsversion}.tar.gz https://github.com/OCSInventory-NG/OCSInventory-ocsreports/releases/download/${ocsversion}/OCSNG_UNIX_SERVER_${ocsversion}.tar.gz
if [ $? -ne 0 ]; then
  echo "Failed to download OCSNG_UNIX_SERVER_${ocsversion}.tar.gz"
  echo "https://github.com/OCSInventory-NG/OCSInventory-ocsreports/releases/download/${ocsversion}/OCSNG_UNIX_SERVER_${ocsversion}.tar.gz"
  exit
fi

tar -xzf OCSNG_UNIX_SERVER_${ocsversion}.tar.gz

cd OCSNG_UNIX_SERVER_${ocsversion}
yes "" | sh setup.sh

a2enconf ocsinventory-reports
a2enconf z-ocsinventory-server
a2enconf zz-ocsinventory-restapi
chown -R www-data:www-data /var/lib/ocsinventory-reports

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


####################

#
wget -O glpi-${glpiversion}.tgz https://github.com/glpi-project/glpi/releases/download/${glpiversion}/glpi-${glpiversion}.tgz

if [ $? -ne 0 ]; then
  echo "Failed to download glpi-${glpiversion}.tgz"
  echo "https://github.com/glpi-project/glpi/releases/download/${glpiversion}/glpi-${glpiversion}.tgz"
  exit
fi

tar -xvf glpi-${glpiversion}.tgz
mv glpi /var/www/html/
chmod 755 -R /var/www/html/
chown -R www-data:www-data /var/www/html/

#
wget -O glpi-ocsinventoryng-${pluginglpiocsversion}.tar.gz https://github.com/pluginsGLPI/ocsinventoryng/releases/download/${pluginglpiocsversion}/glpi-ocsinventoryng-${pluginglpiocsversion}.tar.gz

if [ $? -ne 0 ]; then
  echo "Failed to download glpi-ocsinventoryng-${pluginglpiocsversion}.tar.gz"
  echo "https://github.com/pluginsGLPI/ocsinventoryng/releases/download/${pluginglpiocsversion}/glpi-ocsinventoryng-${pluginglpiocsversion}.tar.gz"
  exit
fi

tar -xvf glpi-ocsinventoryng-${pluginglpiocsversion}.tar.gz
mv ocsinventoryng /var/www/html/glpi/plugins/

# clean install
rm -rf /tmp/*
rm -rf /ocs-glpi.sh*

#
systemctl reload apache2
