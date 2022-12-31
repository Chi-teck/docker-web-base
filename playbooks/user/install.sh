#!/usr/bin/env bash

set -Eeuo pipefail

apt-get -y install sudo

groupadd -g $USER_GID $USER_NAME
useradd $USER_NAME -m -u $USER_UID -g $USER_GID -Gsudo -s /bin/bash
echo $USER_NAME:$USER_PASSWORD | chpasswd

cp -R $DIR/config /home/$USER_NAME/.config

touch /etc/sudoers.lecture
echo 'Defaults lecture_file = /etc/sudoers.lecture' >> /etc/sudoers
