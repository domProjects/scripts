#!/bin/bash

glpiversion="9.3.2"
pluginglpiocsversion="1.5.4"

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
