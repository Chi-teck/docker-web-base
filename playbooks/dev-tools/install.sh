#!/usr/bin/env bash

set -Eeuo pipefail

apt-get -y install \
    apt-utils \
    apache2-utils \
    iputils-ping \
    net-tools \
    procps \
    gnupg \
    git \
    vim \
    mc \
    silversearcher-ag \
    man \
    jq \
    patch \
    tree \
    ncdu \
    rsync \
    less \
    bat \
    bash-completion

# Install HR.
wget -q https://raw.githubusercontent.com/LuRsT/hr/master/hr -O /usr/local/bin/hr
chmod +x /usr/local/bin/hr

# Rename Bat.
mv /usr/bin/batcat /usr/bin/bat

# Install Task.
URL=$(curl -s /tmp https://api.github.com/repos/go-task/task/releases/latest | grep "browser_download_url.*task_linux_amd64\.deb" | cut -d : -f 2,3 | tr -d \")
wget -q -P /tmp $URL && dpkg -i /tmp/task_linux_amd64.deb && rm /tmp/task_linux_amd64.deb

# Configuration.
cp $DIR/vimrc /etc/vim/vimrc.local
cp $DIR/vim/colors/termschool.vim /usr/share/vim/vim82/colors
cp $DIR/gitconfig /etc/gitconfig
