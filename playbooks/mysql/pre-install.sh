#!/usr/bin/env bash

set -Eeuo pipefail

export MYSQL_USER=${MYSQL_USER:-'root'}
export MYSQL_PASSWORD=${MYSQL_PASSWORD:-123}
