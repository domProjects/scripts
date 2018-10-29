#!/bin/bash

# glpi
glpiversion="9.3.2"
pluginglpiocsversion="1.5.4"

ocsteamviewer="1.1"
ocsnetworkshare="1.0"
ocsofficepack="2.0"
ocssecurity="1.1"



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
