#!/usr/bin/env bash

set -Eeuo pipefail

# Return orignal PgSQL directory if the mounted one is empty.
if [ ! "$(ls -A "/var/lib/postgresql/15/main")" ]; then
  cp -pRT /var/lib/postgresql_init /var/lib/postgresql/15/main
fi

service postgresql start
