#!/usr/bin/env bash

set -Eeuo pipefail

export MARIADB_USER=${MARIADB_USER:-'root'}
export MARIADB_PASSWORD=${MARIADB_PASSWORD:-123}
