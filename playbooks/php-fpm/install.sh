#!/usr/bin/env bash

set -Eeuo pipefail

apt-get -y install php$PHP_VERSION-fpm

cp $DIR/30-local.ini /etc/php/$PHP_VERSION/fpm/conf.d/30-local.ini
if [[ -n ${PLAYBOOK_MAILHOG:-} ]]; then
  echo 'sendmail_path = /usr/local/bin/mhsendmail' >> /etc/php/$PHP_VERSION/fpm/conf.d/30-local.ini
fi
