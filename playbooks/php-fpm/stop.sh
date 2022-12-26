#!/usr/bin/env bash

set -Eeuo pipefail

service php$PHP_VERSION-fpm stop
