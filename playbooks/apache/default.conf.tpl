<VirtualHost *:80>

  ServerName localhost
  ServerAdmin webmaster@localhost
  DocumentRoot ${WEB_ROOT}

  ErrorLog ${APACHE_LOG_DIR}/error.log
  CustomLog ${APACHE_LOG_DIR}/access.log combined

  <Directory ${WEB_ROOT}/>
    Options Indexes FollowSymLinks MultiViews
    AllowOverride All
    Order allow,deny
    allow from all
  </Directory>

</VirtualHost>
