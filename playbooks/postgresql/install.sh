#!/usr/bin/env bash

set -Eeuo pipefail

sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
apt -y update && apt-get install postgresql-15 -y

# SSL slows down the connection a big deal.
sed -i 's/ssl = on/ssl = off/g' /etc/postgresql/15/main/postgresql.conf

if [[ -n  ${PLAYBOOK_USER:-} ]]; then
  service postgresql start
  sudo -u postgres psql -c"CREATE USER ${USER_NAME} WITH LOGIN CREATEDB PASSWORD '${POSTGRESQL_PASSWORD}';"
  sudo -u postgres createdb ${USER_NAME} --owner=${USER_NAME}
  service postgresql stop
fi

cp $DIR/psqlrc "$(pg_config --sysconfdir)"/

# Preserve default PostgreSQL data.
cp -a /var/lib/postgresql/15/main  /var/lib/postgresql_init
