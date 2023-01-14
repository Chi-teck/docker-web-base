## Nginx

### Available variables

- WEB_ROOT (default value: /var/www)

### Configuration

Additional virtual hosts can be added as follows.
```Dockerfile
COPY example.conf /etc/nginx/sites-available/example.conf
RUN ln -s /etc/nginx/sites-available/example.conf /etc/nginx/sites-enabled/example.conf
```
