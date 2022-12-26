#!/usr/bin/env bash

set -Eeuo pipefail

export USER_NAME=${USER_NAME:-'az'}
export USER_PASSWORD=${USER_PASSWORD:-'123'}
export USER_UID=${USER_UID:-1000}
export USER_GID=${USER_GID:-$USER_UID}

