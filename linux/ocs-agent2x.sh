#!/bin/bash

# add repository
add-apt-repository universe

#
apt-get -y install build-essential
apt-get -y install cpanminus
apt-get -y install make gcc
apt-get -y install dmidecode
apt-get -y install pciutils
apt-get -y install nmap
apt-get -y install libcrypt-ssleay-perl
apt-get -y install libmodule-install-perl
apt-get -y install libxml-simple-perl
apt-get -y install libcompress-zlib-perl
apt-get -y install libnet-ip-perl
apt-get -y install libwww-perl
apt-get -y install libdigest-md5-perl
apt-get -y install libdata-uuid-perl
apt-get -y install libnet-snmp-perl
apt-get -y install libproc-pid-file-perl
apt-get -y install libproc-daemon-perl
apt-get -y install net-tools
apt-get -y install libsys-syslog-perl
apt-get -y install read-edid
#apt-get -y install smartmontools

#
cpan -i XML::Simple
cpan -i Compress::Zlib
cpan -i Net::IP
cpan -i Net::SNMP
cpan -i Net::Netmask
cpan -i Net::CUPS
cpan -i LWP::UserAgent
cpan -i LWP::Protocol::https
cpan -i Digest::MD5
cpan -i Net::SSLeay
cpan -i Data::UUID
cpan -i IO::Socket::SSL
cpan -i Crypt::SSLeay
cpan -i Proc::Daemon
cpan -i Proc::PID::File
cpan -i Nmap::Parser
cpan -i Module::Install
cpan -i Parse::EDID

#
wget https://github.com/OCSInventory-NG/UnixAgent/releases/download/v2.4.2/Ocsinventory-Unix-Agent-2.4.2.tar.gz
tar –xvzf Ocsinventory-Unix-Agent-2.4.2.tar.gz
cd Ocsinventory-Unix-Agent-2.4.2
env PERL_AUTOINSTALL=1 perl Makefile.PL
make
make install