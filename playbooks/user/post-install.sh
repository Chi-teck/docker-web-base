#!/usr/bin/env bash

home_dir=/home/$USER_NAME;
echo -e "\ncd ${WEB_ROOT:-$home_dir}" >> $home_dir/.bashrc

chown -R $USER_NAME:$USER_NAME /home/$USER_NAME
