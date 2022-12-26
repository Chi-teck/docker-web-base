#!/usr/bin/env bash

set -Eeuo pipefail

mysql_version=8.22

cd /tmp
wget https://repo.mysql.com//mysql-apt-config_0.${mysql_version}-1_all.deb
dpkg -i mysql-apt-config_0.${mysql_version}-1_all.deb
apt update && apt install -y mysql-server

echo 'user = mysql' >> /etc/mysql/mysql.conf.d/mysqld.cnf

# Preserve default MySQL data.
cp -a /var/lib/mysql  /var/lib/mysql_init

