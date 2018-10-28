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
mv teamviewer.zip /etc/ocsinventory-server/plugins/
