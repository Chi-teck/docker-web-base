# Apache (with dev tools and PHP)

## Usage (Docker Compose)

```yml
services:
  php:
    image: attr/dev-apache-php:${PHP_VERSION}
```

## Xdebug
Xdebug is not loaded by default. Use the following command to enable it when needed.
```
sudo xdebug on
```
