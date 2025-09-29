FROM debian:trixie-slim

ARG PHP_VERSION=8.4
ENV DEBIAN_FRONTEND=noninteractive LANG=C.UTF-8 LC_ALL=C.UTF-8

RUN apt update && apt install -y lsb-release wget && \
    wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list && \
    apt purge -y --auto-remove lsb-release wget

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
    php$PHP_VERSION-fpm \
    php$PHP_VERSION-mysql \
    php$PHP_VERSION-pgsql \
    php$PHP_VERSION-redis

RUN cd /tmp && \
    php -r "copy('https://getcomposer.org/download/2.8.12/composer.phar', 'composer.phar');" && \
    echo "f446ea719708bb85fcbf4ef18def5d0515f1f9b4d703f6d820c9c1656e10a2f2  composer.phar" | sha256sum -c && \
    chmod +x composer.phar && mv composer.phar /usr/local/bin/composer

# Listen TCP port instead of socket.
RUN sed -i "s/^listen = .*$/listen = 9000/" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf

# Create an executable that does not require knowing PHP version.
RUN ln -s /usr/sbin/php-fpm${PHP_VERSION} /usr/local/bin/php-fpm

STOPSIGNAL SIGQUIT
CMD ["php-fpm", "-F"]
