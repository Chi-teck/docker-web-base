#!/usr/bin/env bash

set -Eeuo pipefail

if [[ -n  ${PLAYBOOK_MARIADB:-} || -n ${PLAYBOOK_MYSQL:-} ]]; then
  apt install php$PHP_VERSION-mysql
fi

if [[ -n  ${PLAYBOOK_POSTGRESQL:-} ]]; then
  apt install php$PHP_VERSION-pgsql
fi

if [[ -n ${PLAYBOOK_MAILHOG:-} ]]; then
  echo 'sendmail_path = /usr/local/bin/mhsendmail' >> /etc/php/$PHP_VERSION/cli/conf.d/30-local.ini
fi

# Xdebug is not loaded at system boot to avoid performance impact.
xdebug off
