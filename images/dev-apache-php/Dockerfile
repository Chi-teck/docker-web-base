FROM attr/dev

ARG PHP_VERSION=8.4

USER root

RUN apt-get update && apt-get install -y apache2 && \
    sed -i 's#/var/www/html#/var/www#g' /etc/apache2/sites-available/*.conf

COPY create-cert.sh /usr/lib/create-cert.sh
RUN /usr/lib/create-cert.sh

RUN echo 'ServerName localhost' >> /etc/apache2/apache2.conf && \
    apt update && apt install -y lsb-release wget && \
    wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list && \
    a2enmod rewrite ssl && \
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
    libapache2-mod-php$PHP_VERSION

COPY 30-local-cli.ini /etc/php/$PHP_VERSION/cli/conf.d/30-local.ini
COPY 30-local-apache.ini /etc/php/$PHP_VERSION/apache2/conf.d/30-local.ini

# Install Composer.
RUN cd /tmp && \
    curl -o composer.phar https://getcomposer.org/download/2.8.12/composer.phar && \
    echo "f446ea719708bb85fcbf4ef18def5d0515f1f9b4d703f6d820c9c1656e10a2f2  composer.phar" | sha256sum -c && \
    chmod +x composer.phar && mv composer.phar /usr/local/bin/composer

COPY xdebug.sh /usr/local/bin/xdebug
RUN chmod +x /usr/local/bin/xdebug && phpdismod -s ALL xdebug

COPY apache2-foreground.sh /usr/local/bin/apache2-foreground
CMD ["apache2-foreground"]
