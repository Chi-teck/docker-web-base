#!/usr/bin/env bash

set -Eeuo pipefail

if [[ -n  ${PLAYBOOK_MARIADB:-} || -n ${PLAYBOOK_MYSQL:-} ]]; then
  apt install -y php$PHP_VERSION-mysql
fi

if [[ -n  ${PLAYBOOK_POSTGRESQL:-} ]]; then
  apt install -y php$PHP_VERSION-pgsql
fi

if [[ -n  ${PLAYBOOK_REDIS:-} ]]; then
  apt install -y php-redis
fi

if [[ -n  ${PLAYBOOK_DEV_TOOLS:-} ]]; then
  composer completion bash > /etc/bash_completion.d/composer
fi

# Xdebug is not loaded at system boot to avoid performance impact.
# This needs to be done in post-install hook to ensure mod-apache and php-fpm are already installed.
phpdismod -v $PHP_VERSION xdebug
