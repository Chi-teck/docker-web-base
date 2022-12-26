<IfModule mod_ssl.c>
  <VirtualHost _default_:443>

    ServerName localhost
    ServerAdmin webmaster@localhost
    DocumentRoot ${WEB_ROOT}

    SSLEngine on
    SSLCertificateFile /etc/ssl/certs/localhost.crt
    SSLCertificateKeyFile /etc/ssl/private/localhost.key

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined

    <Directory ${WEB_ROOT}/>
      Options Indexes FollowSymLinks MultiViews
      AllowOverride All
      Order allow,deny
      allow from all
    </Directory>

  </VirtualHost>
</IfModule>

