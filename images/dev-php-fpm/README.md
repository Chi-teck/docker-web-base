# PHP-FPM (with dev tools)

## Usage (Docker Compose)

```yml
services:
  php:
    image: attr/dev-php-fpm:${PHP_VERSION}
```

In order to change php-fpm user create a custom Docker file like following. 
```Dockerfile
ARG PHP_VERSION

FROM attr/dev-php-fpm:${PHP_VERSION}

ARG PHP_VERSION
ARG FPM_USER

RUN sed -i "s/user = www-data/user = ${FPM_USER}/g" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf && \
    sed -i "s/group = www-data/group = ${FPM_USER}/g" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf
```

```yml
services:
  php:
    build:
      context: images/php
      args:
        PHP_VERSION: ${PHP_VERSION}
        FPM_USER: ${USER_NAME}
```


## Xdebug
Xdebug is not loaded by default. Use the following command to enable it when needed.
```
sudo xdebug on
```
