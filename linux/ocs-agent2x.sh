#!/bin/bash

# add repository
add-apt-repository universe

#
apt-get -y install build-essential
apt-get -y install cpanminus
apt-get -y install make gcc
apt-get -y install dmidecode
apt-get -y install pciutils

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
mkdir -p /usr/local/src/nmap
cd /usr/local/src/nmap

wget http://nmap.org/dist/nmap-7.70.tar.bz2

tar xvjf nmap-7.70.tar.bz2
cd nmap-7.70

./configure
