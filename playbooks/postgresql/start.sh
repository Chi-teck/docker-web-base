#!/usr/bin/env bash

set -Eeuo pipefail

if [ -f /var/lib/postgresql/docker-initialized ]; then
  echo 'Starting with existing PostgreSQL data.'
else
  echo 'Initializing PostgreSQL data.'
  cp -R /var/lib/postgresql_init/. /var/lib/postgresql
  chown -R postgres:postgres /var/lib/postgresql
  touch /var/lib/postgresql/docker-initialized
fi

service postgresql start
