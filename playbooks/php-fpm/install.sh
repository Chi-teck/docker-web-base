#!/usr/bin/env bash

set -Eeuo pipefail

apt-get -y install php$PHP_VERSION-fpm

cp $DIR/30-local.ini /etc/php/$PHP_VERSION/fpm/conf.d/30-local.ini
if [[ -n ${PLAYBOOK_MAILHOG:-} ]]; then
  echo 'sendmail_path = /usr/local/bin/mhsendmail' >> /etc/php/$PHP_VERSION/fpm/conf.d/30-local.ini
fi

if [[ -n ${PHP_FPM_USER:-} ]]; then
  sed -i "s/user = www-data/user = $PHP_FPM_USER/g" /etc/php/$PHP_VERSION/fpm/pool.d/www.conf
fi
if [[ -n ${PHP_FPM_GROUP:-} ]]; then
  sed -i "s/group = www-data/group = broker/g" /etc/php/$PHP_VERSION/fpm/pool.d/www.conf
fi

