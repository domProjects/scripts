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


if [ $os_family = debian ]; then
  #
  add-apt-repository universe
  # update
  apt-get clean
  apt-get update && apt-get dist-upgrade
  # Install prereqs
  apt-get -y install apache2 \
  php7.2 libapache2-mod-php7.2 \
  php7.2-cgi php7.2-cli php7.2-curl php7.2-gd php7.2-json php7.2-ldap php7.2-mysql php7.2-opcache php7.2-snmp php7.2-xml php7.2-xmlrpc \
  php-pear \
  make gcc \
  perl perl-modules-5.26 libnet-ip-perl libxml-simple-perl libperl5.26 libdbi-perl libarchive-zip-perl build-essential
  # install modul perl
  perl -MCPAN -e 'install Apache::DBI'
  ##perl -MCPAN -e 'install Archive::Zip'
  ##perl -MCPAN -e 'install Compress::Zlib'
  #perl -MCPAN -e 'install DBI'
  #perl -MCPAN -e 'install DBD::Mysql'
  #perl -MCPAN -e 'install Mojolicious::Lite'
  perl -MCPAN -e 'install Net::IP'
  #perl -MCPAN -e 'install Plack::Handler'
  #perl -MCPAN -e 'install SOAP::Lite'
  perl -MCPAN -e 'install XML::Entities'
  #perl -MCPAN -e 'install XML::Simple'
  # restart apache
  systemctl restart apache2

  # install data base
  apt-get -y install mysql-server phpmyadmin

  # clean apt
  apt autoremove
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
