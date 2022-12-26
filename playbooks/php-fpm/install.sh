#!/usr/bin/env bash

set -Eeuo pipefail

apt-get -y install php$PHP_VERSION-fpm

cp $DIR/30-local-fpm.ini /etc/php/$PHP_VERSION/fpm/conf.d/30-fpm.ini
