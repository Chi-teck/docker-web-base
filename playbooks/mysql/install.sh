#!/usr/bin/env bash

set -Eeuo pipefail

mysql_version=8.22

file=mysql-apt-config_0.${mysql_version}-1_all.deb
wget https://repo.mysql.com/$file
dpkg -i $file
apt update && apt install -y mysql-server
rm $file

echo 'user = mysql' >> /etc/mysql/mysql.conf.d/mysqld.cnf

# Preserve default MySQL data.
cp -a /var/lib/mysql /var/lib/mysql_init

