#!/bin/bash

# Sources
#
# https://github.com/PluginsOCSInventory-NG

#
ocsplugin_teamviewer="1.5.4"

#
clear

#
cd /tmp/


#
wget -O teamviewer.zip https://github.com/PluginsOCSInventory-NG/teamviewer/releases/download/1.1/teamviewer.zip
if [ $? -ne 0 ]; then
    echo "Failed to download teamviewer.zip"
    echo "https://github.com/PluginsOCSInventory-NG/teamviewer/releases/download/1.1/teamviewer.zip"
    exit
fi

#
mv teamviewer.zip /usr/share/ocsinventory-reports/ocsreports/download/

#
wget -O networkshare.zip https://github.com/PluginsOCSInventory-NG/networkshare/releases/download/1.0/networkshare.zip
if [ $? -ne 0 ]; then
    echo "Failed to download networkshare.zip"
    echo "https://github.com/PluginsOCSInventory-NG/networkshare/releases/download/1.0/networkshare.zip"
    exit
fi

#
mv networkshare.zip /usr/share/ocsinventory-reports/ocsreports/download/
