#!/usr/bin/env bash

set -Eeuo pipefail

wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list

apt-get update && apt-get install -y \
    php$PHP_VERSION \
    php$PHP_VERSION-apcu \
    php$PHP_VERSION-bcmath \
    php$PHP_VERSION-cgi \
    php$PHP_VERSION-curl \
    php$PHP_VERSION-igbinary \
    php$PHP_VERSION-intl \
    php$PHP_VERSION-gd \
    php$PHP_VERSION-mbstring \
    php$PHP_VERSION-sqlite3 \
    php$PHP_VERSION-xdebug \
    php$PHP_VERSION-xml \
    php$PHP_VERSION-zip

ini_file=/etc/php/$PHP_VERSION/cli/conf.d/30-local.ini
cp $DIR/30-local.ini $ini_file
if [[ -n ${PLAYBOOK_MAILHOG:-} ]]; then
  echo 'sendmail_path = /usr/local/bin/mhsendmail' >> $ini_file
fi

# Install Composer.
cd /tmp

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"

chmod +x composer.phar && mv composer.phar /usr/local/bin/composer

if [[ ${PLAYBOOK_APACHE:-} ]]; then
  sapi='apache2handler'
elif [[ ${PLAYBOOK_PHP_FPM:-} ]]; then
  sapi='fpm-fcgi'
fi

# shellcheck disable=SC2016
esh -s /bin/bash -o /usr/local/bin/xdebug $DIR/xdebug.sh.tpl SAPI=${sapi:-}
chmod +x /usr/local/bin/xdebug
