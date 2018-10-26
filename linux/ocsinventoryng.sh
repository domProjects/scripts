#!/bin/bash

# OCS Inventory
ocsversion="2.5"
ocsdbhost="localhost"
ocsdbhostport="3306"

# get os from system
os=`cat /etc/*release | grep ^ID= | cut -d= -f2 | sed 's/\"//g'`

# get os family from system
if [ $os = debian ] || [ $os = fedora ]; then
  os_family=$os
else
  os_family=`cat /etc/*release | grep ^ID_LIKE= | cut -d= -f2 | sed 's/\"//g' | cut -d' ' -f2`
fi

# Install prereqs
if [ $os_family = debian ]; then
  apt-get -y install apache2 \
  mod_perl \
  php7.2 \
  mariadb-client \
  libxml-simple-perl libperl5.26 libdbi-perl libnet-ip-perl libarchive-zip-perl make build-essential
  #cpan install XML::Entities

elif [ $os_family = fedora ]; then
  yum -y install epel-release
  # Install more prereqs
  yum install -y php-curl httpd httpd-devel gcc mod_perl mod_php mod_ssl make perl-XML-Simple perl-Compress-Zlib perl-DBI \
  perl-DBD-MySQL perl-Net-IP perl-SOAP-Lite perl-Archive-Zip php-common php-gd php-mbstring php-soap php-mysql php-ldap \
  php-xml cpanminus
  # enable and start httpd
  systemctl enable httpd
  systemctl start httpd
else
  echo "unknown operating system family"
  exit 1
fi
