#!/usr/bin/env bash

set -Eeuo pipefail

sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
apt -y update && apt-get install postgresql-15 -y

# SSL slows down the connection a big deal.
sed -i 's/ssl = on/ssl = off/g' /etc/postgresql/15/main/postgresql.conf

service postgresql start
sudo -u postgres psql -c"ALTER user postgres WITH PASSWORD '${POSTGRESQL_PASSWORD}'"
service postgresql stop

# Preserve default PostgreSQL data.
cp -a /var/lib/postgresql  /var/lib/postgresql_init
