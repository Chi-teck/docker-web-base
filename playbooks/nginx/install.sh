#!/usr/bin/env bash

set -Eeuo pipefail

apt-get -y install nginx

if [[ -n ${PLAYBOOK_PHP_FPM:-} ]]; then
  TEMPLATE=$DIR/default-php.tpl
else
  TEMPLATE=$DIR/default.tpl
fi
envsubst '$WEB_ROOT, $PHP_VERSION' < $TEMPLATE > /etc/nginx/sites-available/default
