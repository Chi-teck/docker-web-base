#!/usr/bin/env bash

set -Eeuo pipefail

phpmyadmin_version='5.2.0'

# Install PhpMyAdmin.
wget https://files.phpmyadmin.net/phpMyAdmin/$phpmyadmin_version/phpMyAdmin-$phpmyadmin_version-all-languages.zip
unzip phpMyAdmin-$phpmyadmin_version-all-languages.zip
mv phpMyAdmin-$phpmyadmin_version-all-languages /usr/share/phpmyadmin
rm phpMyAdmin-$phpmyadmin_version-all-languages.zip

if [[ -n ${PLAYBOOK_MYSQL:-} ]]; then
  user=$MYSQL_USER
  password=$MYSQL_PASSWORD
elif [[ -n ${PLAYBOOK_MARIADB:-} ]]; then
  user=$MARIADB_USER
  password=$MARIADB_PASSWORD
else
  >&2 echo -e '\e[31mPhpAdmin requires credentials for MySQL database.\e[0m'
  exit 1
fi

USER=$user PASSWORD=$password envsubst '$USER, $PASSWORD' < $DIR/config.inc.php.tpl > /usr/share/phpmyadmin/config.inc.php
