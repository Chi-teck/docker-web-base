#!/usr/bin/env bash

set -Eeuo pipefail

exec nginx -g 'daemon off;'
