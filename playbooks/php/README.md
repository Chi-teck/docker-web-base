## PHP playbook

### Available variables

- PHP_VERSION (default value: 8.2)

### Configuration

In order to override default PHP settings create settings file and copy it to the PHP configuration directory as follows.
```Dockerfile
COPY my-settings.ini /etc/php/${PHP_VERSION}/cli/conf.d/30-local.ini
```

### Xdebug
Xdebug is not loaded by default. Use the following command to enable it when needed.
```
sudo xdebug on
```
