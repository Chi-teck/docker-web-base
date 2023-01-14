## Apache

### Available variables

- WEB_ROOT (default value: /var/www)

### Configuration

Additional virtual hosts can be added as follows.
```Dockerfile
COPY example.conf /etc/apache2/sites-available/example.conf
RUN a2ensite example.conf
```

### PHP
PHP module is installed when [PHP playbook](../php/README.md) is available.

PHP settings can be overriden as follows.
```
COPY my-settings.ini /etc/php/${PHP_VERSION}/apache2/conf.d/30-local.ini
```
