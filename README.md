# Docker Web Base

A Docker image for web development.

This image follows mutli-service apprach, which means all services are running in the same container.
Th services can be configured using [playbooks](./playbooks).
```Dockerfile
FROM attr/web-base

ENV PHP_VERSION=8.2

RUN playbook user dev-tools nginx mysql php-fpm
```

Note, that the image is intended for local development and should never be used on production environments.
