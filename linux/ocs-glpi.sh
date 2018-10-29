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

#
apt-get -y install php7.2
apt-get -y install php7.2-curl
apt-get -y install php7.2-mbstring
apt-get -y install php7.2-snmp
apt-get -y install php7.2-soap
apt-get -y install php7.2-xml
apt-get -y install libapache2-mod-perl2

#
cpan -i Apache::DBI
cpan -i Archive::Zip
cpan -i Compress::Zlib
cpan -i DBD::Mysql
cpan -i DBI
cpan -i Mojolicious::Lite
cpan -i Net::IP
cpan -i Plack::Handler
cpan -i XML::Entities
cpan -i XML::Simple
cpan -i YAML



