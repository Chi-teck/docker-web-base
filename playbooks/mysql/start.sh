#!/usr/bin/env bash

set -Eeuo pipefail

if [ -f /var/lib/mysql/docker-initialized ]; then
  echo 'Starting with existing MySQL data.'
  mysqld --user=mysql &
else
  echo 'Initializing MySQL data.'
  cp -a /var/lib/mysql_init/. /var/lib/mysql
cat << SQL > /var/lib/mysql_init/init.sql
ALTER USER '$MYSQL_USER'@'localhost' IDENTIFIED WITH caching_sha2_password BY '$MYSQL_PASSWORD';
CREATE USER '$MYSQL_USER'@'%' IDENTIFIED WITH caching_sha2_password BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;
SQL
  mysqld --user=mysql --init-file=/var/lib/mysql_init/init.sql &
  touch /var/lib/mysql/docker-initialized
fi
