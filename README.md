# Docker Web Base

Docker images for local web development.

> These images are intended for local development only and should never be used in production.

## Images

| Image | Base | Description |
|-------|------|-------------|
| `attr/dev` | `debian:trixie-slim` | Base dev container with git, vim, mc, Node.js, and other tools |
| `attr/dev-apache-php` | `attr/dev` | Apache + PHP with Xdebug and Composer |
| `attr/dev-php-fpm` | `attr/dev` | PHP-FPM with Xdebug, SPX, and Composer |
| `attr/php-fpm` | `debian:trixie-slim` | Minimal PHP-FPM with Composer (no dev tools) |

PHP images are built for versions **7.3-8.5**. The latest version is also tagged as `latest`.

## Usage

### dev

A base image with common dev tools. Extend it with your own Dockerfile:

```dockerfile
FROM attr/dev

ARG USER_NAME
ARG USER_GID
ARG USER_UID
ARG USER_PASSWORD

RUN userdel wb && \
    groupadd -g $USER_GID $USER_NAME && \
    useradd $USER_NAME -m -u $USER_UID -g $USER_GID -Gsudo -s /bin/bash && \
    echo $USER_NAME:$USER_PASSWORD | chpasswd
```

### dev-apache-php

```yaml
services:
  php:
    image: attr/dev-apache-php:8.4
```

### dev-php-fpm

```yaml
services:
  php:
    image: attr/dev-php-fpm:8.4
```

To change the FPM user, create a custom Dockerfile:

```dockerfile
ARG PHP_VERSION
FROM attr/dev-php-fpm:${PHP_VERSION}
ARG PHP_VERSION
ARG FPM_USER

RUN sed -i "s/user = www-data/user = ${FPM_USER}/g" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf && \
    sed -i "s/group = www-data/group = ${FPM_USER}/g" /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf
```

### php-fpm

Minimal PHP-FPM image without dev tools:

```yaml
services:
  php:
    image: attr/php-fpm:8.4
```

## Xdebug

Dev PHP images ship with Xdebug disabled by default. Toggle it with:

```bash
sudo xdebug on
sudo xdebug off
```
