#!/usr/bin/env bash

set -Eeuo pipefail

if [[ -n  ${PLAYBOOK_MARIADB:-} || -n ${PLAYBOOK_MYSQL:-} ]]; then
  apt install php$PHP_VERSION-mysql
fi

if [[ -n  ${PLAYBOOK_POSTGRESQL:-} ]]; then
  apt install php$PHP_VERSION-pgsql
fi

if [[ -n  ${PLAYBOOK_REDIS:-} ]]; then
  apt install php-redis
fi

# Xdebug is not loaded at system boot to avoid performance impact.
# This needs to be done in post-install hook to ensure mod-apache and php-fpm are already installed.
phpdismod -v $PHP_VERSION xdebug

# Directory /etc/bash_completion.d is not created yet when install hook is executed.
composer completion bash > /etc/bash_completion.d/composer
