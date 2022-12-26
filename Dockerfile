FROM debian:bullseye

#--------------------
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

RUN apt-get update && apt-get install --yes runit

#--------------------
COPY playbook.sh /usr/bin/playbook
COPY playbooks /tmp/playbooks
RUN mkdir /root/start /root/stop

#--------------------
RUN playbook base

#--------------------
ENV WEB_ROOT=/var/www \
    PHP_VERSION=8.2 \
    USER_GID=1001

RUN playbook user dev-tools nginx mariadb php-fpm nodejs ssh mailhog phpmyadmin localtunnel

#--------------------
RUN rm -r /tmp/* /usr/bin/playbook

#--------------------
COPY cmd.sh /root/cmd.sh
RUN chmod +x /root/cmd.sh
CMD ["/root/cmd.sh"]
