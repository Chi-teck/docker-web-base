## PHP playbook

### Available variables

- PHP_VERSION (default value: 8.2)

### Configuration

In order to override default PHP settings create settings file and copy it to the PHP configuration directory as follows.
```
COPY my-settings.ini /etc/php/${PHP_VERSION}/cli/conf.d/30-local.ini
```

Note that this would only apply to CLI applications. For other SAPIs the configuration can be changed in the same way.
```
COPY my-settings.ini /etc/php/${PHP_VERSION}/fpm/conf.d/30-local.ini
COPY my-settings.ini /etc/php/${PHP_VERSION}/apache2/conf.d/30-local.ini
```

### Configuration
Xdebug is not loaded by default. Use the following command to enable it when needed.
```
sudo xdebug on
```
