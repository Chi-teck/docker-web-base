#!/usr/bin/env bash

set -Eeuo pipefail

apt-get update
# See https://github.com/phusion/baseimage-docker/issues/319#issuecomment-245857919
apt-get -y install \
  apt-utils \
  curl \
  wget \
  zip \
  unzip \
  apt-transport-https \
  lsb-release \
  ca-certificates \
  dumb-init \
  gettext

DIR=$(dirname -- "${BASH_SOURCE[0]}")

# Install shell template engine.
wget --quiet -O /usr/local/bin/esh https://raw.githubusercontent.com/jirutka/esh/v0.3.2/esh \
    && echo '9084e3e8e70e4ea81c40cd1cf85559196c0fa2cc /usr/local/bin/esh' | sha1sum -c || exit 1
chmod +x /usr/local/bin/esh

openssl req \
    -newkey rsa:2048 \
    -x509 \
    -nodes \
    -keyout server.pem \
    -new \
    -keyout /etc/ssl/private/localhost.key \
    -out /etc/ssl/certs/localhost.crt \
    -subj /CN=localhost \
    -reqexts SAN \
    -extensions SAN \
    -config <(cat /usr/lib/ssl/openssl.cnf <(printf '[SAN]\nsubjectAltName=DNS:localhost')) \
    -sha256 \
    -days 365

cat $DIR/bashrc >> /etc/skel/.bashrc
# shellcheck disable=SC2028
echo 'export PS1="\[\e[101;39m\] \u@\h \[\e[0m\]\[\e[103;30m\] \w \[\e[0m\]\n\[\e[01;30m\]$ \[\e[0m\]"' >> /root/.bashrc
