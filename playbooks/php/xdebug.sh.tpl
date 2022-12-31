#!/usr/bin/env bash

set -Eeuo pipefail

if [[ $EUID != 0 ]]; then
  >&2 echo -e '\e[31mThis command should be run as root.\e[0m'
  exit 1
fi

command=${1:-}

if [[ $command == 'on' ]]; then
  phpenmod -v $PHP_VERSION xdebug
elif [[ $command == 'off' ]]; then
  phpdismod -v $PHP_VERSION xdebug
else
  # shellcheck disable=SC2046
  >&2 echo 'Usage:' $(basename -- "$0") '[on|off]';
  exit 1
fi

if [[ ${SERVER:-} == 'apache' ]]; then
  # Apache fails with "signal Segmentation fault" when reload is used.
  service apache2 restart
elif [[ ${SERVER:-} == 'nginx' ]]; then
  service nginx reload
fi
