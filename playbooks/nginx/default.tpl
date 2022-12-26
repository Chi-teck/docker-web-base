#
# Default server configuration
#
server {
  listen 80 default_server;
  listen [::]:80;

  # SSL configuration
  listen 443 ssl default_server;
  listen [::]:443 ssl default_server;
  ssl_certificate /etc/ssl/certs/localhost.crt;
  ssl_certificate_key /etc/ssl/private/localhost.key;

  root ${WEB_ROOT};

  index index.html;

  location / {
    try_files $uri $uri/ =404;
    autoindex on;
  }

}
