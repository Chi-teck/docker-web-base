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

  index index.html index.php;

  location / {
    try_files $uri $uri/ =404;
    autoindex on;
  }

  location ~ \.php$ {
    include snippets/fastcgi-php.conf;
    fastcgi_read_timeout 500;
    fastcgi_buffers 16 16k;
    fastcgi_buffer_size 32k;
    fastcgi_pass unix:/run/php/php${PHP_VERSION}-fpm.sock;
  }

  location ~ /\. {
    deny all;
  }

  location ~ (.*/web) {
    try_files $uri $1/index.php?$query_string;
  }
}
