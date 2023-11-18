## PHP-FPM playbook

### Available variables

- PHP_FPM_USER
- PHP_FPM_GROUP

### Configuration

In order to override default PHP settings create settings file and copy it to the PHP configuration directory as follows.
```Dockerfile
COPY my-settings.ini /etc/php/${PHP_VERSION}/fpm/conf.d/30-local.ini
```

### Xdebug
See [PHP playbook](../php/README.md) on how to enable Xdebug.
