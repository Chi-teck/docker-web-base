#!/usr/bin/env bash

set -Eeuo pipefail

# We don't use "apache2ctl" here because it does not use "exec",
# which leaves an undesirable resident shell process.

APACHE_CONFDIR='/etc/apache2'
source ${APACHE_CONFDIR}/envvars

[ ! -d ${APACHE_RUN_DIR:-/var/run/apache2} ] && mkdir -p ${APACHE_RUN_DIR:-/var/run/apache2}
[ ! -d ${APACHE_RUN_DIR:-/var/run/apache2}/socks ] && mkdir -m 755 ${APACHE_RUN_DIR:-/var/run/apache2}/socks && chown ${APACHE_RUN_USER:-www-data} ${APACHE_RUN_DIR:-/var/run/apache2}/socks
[ ! -d ${APACHE_LOCK_DIR:-/var/lock/apache2} ] && mkdir -m 755 ${APACHE_LOCK_DIR:-/var/lock/apache2} && chown ${APACHE_RUN_USER:-www-data} ${APACHE_LOCK_DIR:-/var/lock/apache2}

exec apache2 -DFOREGROUND
