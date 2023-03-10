server {

  listen 8088;

  root /usr/share/phpmyadmin;

  index index.php;

  location ~ \.php$ {
    include snippets/fastcgi-php.conf;
    fastcgi_pass unix:/run/php/php${PHP_VERSION}-fpm.sock;
  }
  
}
