#!/usr/bin/env bash

home_dir=/home/$USER_NAME;
echo -e "\ncd ${WEB_ROOT:-$home_dir}" >> $home_dir/.bashrc

chown -R $USER_NAME:$USER_NAME /home/$USER_NAME

if [[ -n ${PLAYBOOK_APACHE:-} || -n ${PLAYBOOK_NGINX:-} ]]; then
    usermod -a -G www-data $USER_NAME
fi
