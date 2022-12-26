#!/usr/bin/env bash

set -Eeuo pipefail

if [[ -n ${PLAYBOOK_APACHE:-} ]]; then
  cp $DIR/phpmyadmin.conf /etc/apache2/sites-available/phpmyadmin.conf
  a2ensite phpmyadmin
fi

if [[ -n ${PLAYBOOK_NGINX:-} ]]; then
  envsubst '$PHP_VERSION' < $DIR/phpmyadmin.tpl > /etc/nginx/sites-available/phpmyadmin
  ln -s /etc/nginx/sites-available/phpmyadmin /etc/nginx/sites-enabled/phpmyadmin
fi
