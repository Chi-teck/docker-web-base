#!/usr/bin/env bash

set -Eeuo pipefail

apt-get -y install \
    net-tools \
    apt-utils \
    procps \
    gnupg \
    git \
    vim \
    mc \
    silversearcher-ag \
    bsdmainutils \
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
wget  --quiet https://raw.githubusercontent.com/LuRsT/hr/master/hr
chmod +x hr
mv hr /usr/local/bin/

# Rename Bat.
mv /usr/bin/batcat /usr/bin/bat

# Install Task.
URL=$(curl -s /tmp https://api.github.com/repos/go-task/task/releases/latest | grep "browser_download_url.*task_linux_amd64\.deb" | cut -d : -f 2,3 | tr -d \")
wget  --quiet -P /tmp $URL && dpkg -i /tmp/task_linux_amd64.deb
# @todo Is it still needed?
cp $DIR/task.complete.sh /etc/bash_completion.d/task.complete.sh

# Configuration.
cp $DIR/vimrc /etc/vim/vimrc.local
cp $DIR/vim/colors/termschool.vim /usr/share/vim/vim82/colors
cp $DIR/gitconfig /etc/gitconfig
