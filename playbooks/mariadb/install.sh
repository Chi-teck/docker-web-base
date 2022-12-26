#!/usr/bin/env bash

set -Eeuo pipefail

apt-get -y install mariadb-server mariadb-client

sed -i "s/bind-address/#bind-address/" /etc/mysql/mariadb.conf.d/50-server.cnf

service mariadb start
mysql -uroot -e"SET PASSWORD FOR '$MARIADB_USER'@'localhost' = PASSWORD('$MARIADB_PASSWORD')"
mysql -uroot -e"GRANT ALL ON *.* TO '$MARIADB_USER'@'%' identified by '$MARIADB_PASSWORD'"
mysql -uroot -e"FLUSH PRIVILEGES"

# Preserve default MySQL data.
cp -a /var/lib/mysql  /var/lib/mysql_init
