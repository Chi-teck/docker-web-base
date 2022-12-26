#!/usr/bin/env bash

set -Eeuo pipefail

if [ -f /run/mailhog.pid ]; then
  echo 'Stopping mailhog.'
  # shellcheck disable=SC2046
  kill -SIGTERM $(</run/mailhog.pid)
fi
