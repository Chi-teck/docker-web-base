# Docker Web Base

A Docker image for web development.

This image follows mutli-service approach, which means all services are running in the same container.

## Usage
Configure required service through [playbooks](./playbooks).
```Dockerfile
FROM attr/web-base

ENV PHP_VERSION=8.2

RUN playbook user dev-tools nginx mysql php-fpm
```

## Note
The image is intended for local development and should never be used on production environments.
