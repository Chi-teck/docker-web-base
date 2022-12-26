#!/usr/bin/env bash

set -Eeuo pipefail

if [ -f /var/lib/mysql/docker-initialized ]; then
  echo 'Starting with existing MariaDB data.'
else
  echo 'Initializing MariaDB data.'
  cp -R /var/lib/mysql_init/. /var/lib/mysql
  chown -R mysql:mysql /var/lib/mysql
  touch /var/lib/mysql/docker-initialized
fi
service mariadb start
