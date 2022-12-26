#!/usr/bin/env bash

set -Eeuo pipefail

echo 'Starting mailhog.'
mailhog &

echo $! > /run/mailhog.pid
