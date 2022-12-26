#!/usr/bin/env bash

set -Eeuo pipefail

if [[ -n ${PLAYBOOK_MAILHOG:-} ]]; then
  echo 'sendmail_path = /usr/local/bin/mhsendmail' >> /etc/php/$PHP_VERSION/fpm/conf.d/30-fpm.ini
fi
