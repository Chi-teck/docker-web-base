#!/usr/bin/env bash

set -Eeuo pipefail

if [[ $EUID != 0 ]]; then
  >&2 echo -e '\e[31mThis command must be run as root.\e[0m'
  exit 1
fi

command=${1:-}

if [[ $command == 'on' ]]; then
  phpenmod -s ALL xdebug
elif [[ $command == 'off' ]]; then
  phpdismod -s ALL xdebug
else
  # shellcheck disable=SC2046
  >&2 echo 'Usage:' $(basename -- "$0") '[on|off]';
  exit 1
fi

kill -USR2 1
