#!/usr/bin/env bash

set -Eeuo pipefail

openssl req -x509 -nodes \
  -newkey rsa:2048 \
  -keyout /etc/ssl/private/localhost.key \
  -out /etc/ssl/certs/localhost.crt \
  -subj /CN=localhost \
  -sha256 \
  -days 365
