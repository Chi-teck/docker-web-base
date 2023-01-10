#!/usr/bin/env bash

set -Eeuo pipefail

if [[ -n ${PLAYBOOK_PHP:-} ]]; then
    apt install libapache2-mod-php$PHP_VERSION
    cp $DIR/30-local.ini /etc/php/$PHP_VERSION/apache2/conf.d/30-local.ini
    if [[ -n ${PLAYBOOK_MAILHOG:-} ]]; then
        echo 'sendmail_path = /usr/local/bin/mhsendmail' >> /etc/php/$PHP_VERSION/apache2/conf.d/30-local.ini
    fi
fi
