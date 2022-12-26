#!/usr/bin/env bash

set -Eeuo pipefail

apt-get -y install apache2

a2enmod rewrite ssl
echo 'ServerName localhost' >> /etc/apache2/apache2.conf

envsubst '$WEB_ROOT' < $DIR/default.conf.tpl > /etc/apache2/sites-available/000-default.conf
envsubst '$WEB_ROOT' < $DIR/default-ssl.conf.tpl > /etc/apache2/sites-available/default-ssl.conf
a2ensite default-ssl.conf

