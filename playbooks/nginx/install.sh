#!/usr/bin/env bash

set -Eeuo pipefail

apt-get -y install nginx

if [ -z $PHP_VERSION ]; then
  TEMPLATE=$DIR/default.tpl
else
  TEMPLATE=$DIR/default-php.tpl
fi
envsubst '$WEB_ROOT, $PHP_VERSION' < $TEMPLATE > /etc/nginx/sites-available/default
