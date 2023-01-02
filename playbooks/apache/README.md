## Apache

### Available variables

- WEB_ROOT (default value: /var/www)

### Configuration

Additional virtual hosts can be added as follows.
```Dockerfile
COPY example.conf /etc/apache2/sites-available/example.conf
RUN a2ensite example.conf
```
