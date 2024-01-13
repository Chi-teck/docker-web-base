FROM attr/dev

ARG PHP_VERSION=8.3

USER root

RUN apt update && apt install -y lsb-release && \
    wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list && \
    apt purge -y --auto-remove lsb-release

RUN apt update && apt install -y \
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
    php$PHP_VERSION-zip \
    php$PHP_VERSION-xdebug \
    php$PHP_VERSION-mysql \
    php$PHP_VERSION-pgsql \
    php$PHP_VERSION-redis \
    php$PHP_VERSION-fpm

COPY 30-local-cli.ini /etc/php/$PHP_VERSION/cli/conf.d/30-local.ini
COPY 30-local-fpm.ini /etc/php/$PHP_VERSION/apache/conf.d/30-local.ini

# ini_file=/etc/php/$PHP_VERSION/cli/conf.d/30-local.ini
# cp $DIR/30-local.ini $ini_file

# Install Composer.
RUN cd /tmp && \
    php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('sha384', 'composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    chmod +x composer.phar && mv composer.phar /usr/local/bin/composer

COPY xdebug.sh /usr/local/bin/xdebug
RUN chmod +x /usr/local/bin/xdebug && phpdismod -s ALL xdebug

# Listen TCP port instead of socket.
RUN sed -i "s/^listen = .*$/listen = 9000/" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf

# Create an executable that does not require knowing PHP version.
RUN ln -s /usr/sbin/php-fpm${PHP_VERSION} /usr/local/bin/php-fpm

CMD ["php-fpm", "-F"]
