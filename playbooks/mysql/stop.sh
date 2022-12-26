#!/usr/bin/env bash

set -Eeuo pipefail

echo 'Shutting down MySQL server.'
if [ -f /run/mysqld/mysqld.pid ]; then
  kill $(</run/mysqld/mysqld.pid)
fi
