#!/usr/bin/env bash

set -Eeuo pipefail

if [[ -n  ${PLAYBOOK_MARIADB:-} || -n ${PLAYBOOK_MYSQL:-} ]]; then
  apt install php$PHP_VERSION-mysql
fi

if [[ -n  ${PLAYBOOK_POSTGRESQL:-} ]]; then
  apt install php$PHP_VERSION-pgsql
fi

