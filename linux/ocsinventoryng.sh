#!/bin/bash

# OCS Inventory
ocsversion="2.5"
ocsdbhost="localhost"
ocsdbhostport="3306"

# define apache/httpd config files location
httpconfiglocation=/etc/apache2/conf-available

# Get script arguments for non-interactive mode
while [ "$1" != "" ]; do
    case $1 in
        -u | --dbuser )
            shift
            ocsdbuser="$1"
            ;;
        -p | --dbpwd )
            shift
            ocsdbpwd="$1"
            ;;
        -h | --dbhost )
            shift
            ocsdbhost="$1"
            ;;
        -n | --dbhostportnumber )
            shift
            ocsdbhostport="$1"
            ;;
        -v | --version )
            shift
            ocsversion="$1"
            ;;
    esac
    shift
done


# add repository
add-apt-repository universe

# update apt
apt-get clean
apt-get -y update
apt-get -y upgrade
apt-get -y dist-upgrade
apt-get -y autoremove
apt-get -y upgrade
apt-get -y autoremove

# Install prereqs
apt-get -y install apache2 \
php7.2 php7.2-cgi php7.2-cli php7.2-curl php7.2-gd php7.2-json php7.2-ldap php7.2-mysql php7.2-opcache php7.2-snmp php7.2-xml php7.2-xmlrpc \
php-pear \
make gcc \
perl perl-modules-5.26 libnet-ip-perl libxml-simple-perl libperl5.26 libdbi-perl libarchive-zip-perl build-essential
# install modul perl
perl -MCPAN -e 'install Apache::DBI'
perl -MCPAN -e 'install Net::IP'
perl -MCPAN -e 'install XML::Entities'

# restart apache
systemctl restart apache2

# install data base
apt-get -y install mysql-server phpmyadmin

# update apt
apt-get clean
apt-get -y update
apt-get -y upgrade
apt-get -y dist-upgrade
apt-get -y autoremove
apt-get -y upgrade
apt-get -y autoremove

# clean folder temp
rm -rf /tmp/*


if [ -z "$ocsdbuser" ]; then
    echo
    read -p "Enter the OCS Inventory database username with access: " ocsdbuser
    echo
fi
if [ -z "$ocsdbpwd" ]; then
    echo
    while true
    do
        read -s -p "Enter the OCS Inventory User Database Password: " ocsdbpwd
        echo
        read -s -p "Confirm the OCS Inventory User Database Password: " password2
        echo
        [ "$ocsdbpwd" = "$password2" ] && break
        echo "Passwords don't match. Please try again."
        echo
    done
    echo
fi


# Download OCS Inventory Server
wget -O OCSNG_UNIX_SERVER_${ocsversion}.tar.gz https://github.com/OCSInventory-NG/OCSInventory-ocsreports/releases/download/${ocsversion}/OCSNG_UNIX_SERVER_${ocsversion}.tar.gz
if [ $? -ne 0 ]; then
    echo "Failed to download OCSNG_UNIX_SERVER_${ocsversion}.tar.gz"
    echo "https://github.com/OCSInventory-NG/OCSInventory-ocsreports/releases/download/${ocsversion}/OCSNG_UNIX_SERVER_${ocsversion}.tar.gz"
    exit
fi

# Extract OCS Inventory files
tar -xzf OCSNG_UNIX_SERVER_${ocsversion}.tar.gz

# modifify setup.sh continuing on error
FORCECONTINUE_REPLACETEXT='exit 1'
FORCECONTINUE='echo "error but continuing"'
sed -i "s/$FORCECONTINUE_REPLACETEXT/$FORCECONTINUE/" OCSNG_UNIX_SERVER_${ocsversion}/setup.sh

# run unattended setup script
cd OCSNG_UNIX_SERVER_${ocsversion}
yes "" | sh setup.sh

# modify z-ocsinventory-server.conf with new database user and password replacing lines
OCS_DB_USER_REPLACETEXT='PerlSetEnv OCS_DB_USER'
OCS_DB_USER_NEW="\  PerlSetEnv OCS_DB_USER $ocsdbuser"
sed -i "/$OCS_DB_USER_REPLACETEXT/c $OCS_DB_USER_NEW" $httpconfiglocation/z-ocsinventory-server.conf

OCS_DB_PWD_REPLACETEXT='PerlSetVar OCS_DB_PWD'
OCS_DB_PWD_NEW="\  PerlSetVar OCS_DB_PWD $ocsdbpwd"
sed -i "/$OCS_DB_PWD_REPLACETEXT/c $OCS_DB_PWD_NEW" $httpconfiglocation/z-ocsinventory-server.conf

OCS_DB_HOST_REPLACETEXT='PerlSetEnv OCS_DB_HOST'
OCS_DB_HOST_NEW="\  PerlSetEnv OCS_DB_HOST $ocsdbhost"
sed -i "/$OCS_DB_HOST_REPLACETEXT/c $OCS_DB_HOST_NEW" $httpconfiglocation/z-ocsinventory-server.conf

OCS_DB_PORT_REPLACETEXT='PerlSetEnv OCS_DB_PORT'
OCS_DB_PORT_NEW="\  PerlSetEnv OCS_DB_PORT $ocsdbhostport"
sed -i "/$OCS_DB_PORT_REPLACETEXT/c $OCS_DB_PORT_NEW" $httpconfiglocation/z-ocsinventory-server.conf

# modify zz-ocsinventory-restapi.conf with new database user password and host
OCS_DB_USER_RESTAPI_REPLACETEXT='{OCS_DB_USER} ='
OCS_DB_USER_RESTAPI_NEW="\  \$ENV{OCS_DB_USER} = 'zreplaceholder';"
sed -i "/$OCS_DB_USER_RESTAPI_REPLACETEXT/c $OCS_DB_USER_RESTAPI_NEW" $httpconfiglocation/zz-ocsinventory-restapi.conf
sed -i "s/zreplaceholder/$ocsdbuser/" $httpconfiglocation/zz-ocsinventory-restapi.conf

OCS_DB_PWD_RESTAPI_REPLACETEXT='{OCS_DB_PWD} ='
OCS_DB_PWD_RESTAPI_NEW="\  \$ENV{OCS_DB_PWD} = 'zreplaceholder';"
sed -i "/$OCS_DB_PWD_RESTAPI_REPLACETEXT/c $OCS_DB_PWD_RESTAPI_NEW" $httpconfiglocation/zz-ocsinventory-restapi.conf
sed -i "s/zreplaceholder/$ocsdbpwd/" $httpconfiglocation/zz-ocsinventory-restapi.conf

OCS_DB_HOST_RESTAPI_REPLACETEXT='{OCS_DB_HOST} ='
OCS_DB_HOST_RESTAPI_NEW="\  \$ENV{OCS_DB_HOST} = 'zreplaceholder';"
sed -i "/$OCS_DB_HOST_RESTAPI_REPLACETEXT/c $OCS_DB_HOST_RESTAPI_NEW" $httpconfiglocation/zz-ocsinventory-restapi.conf
sed -i "s/zreplaceholder/$ocsdbhost/" $httpconfiglocation/zz-ocsinventory-restapi.conf

OCS_DB_PORT_RESTAPI_REPLACETEXT='{OCS_DB_PORT} ='
OCS_DB_PORT_RESTAPI_NEW="\  \$ENV{OCS_DB_PORT} = 'zreplaceholder';"
sed -i "/$OCS_DB_PORT_RESTAPI_REPLACETEXT/c $OCS_DB_PORT_RESTAPI_NEW" $httpconfiglocation/zz-ocsinventory-restapi.conf
sed -i "s/zreplaceholder/$ocsdbhostport/" $httpconfiglocation/zz-ocsinventory-restapi.conf

# set permissions and restart service (enable config for debian)
# enable Apache configuration files
a2enconf ocsinventory-reports
a2enconf z-ocsinventory-server
a2enconf zz-ocsinventory-restapi
chown -R www-data:www-data /var/lib/ocsinventory-reports
service apache2 restart
