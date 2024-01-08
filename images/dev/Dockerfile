FROM debian:bookworm-slim

ARG USER_NAME=wb
ARG USER_UID=1000
ARG USER_GID=1000
ARG USER_PASSWORD=123
ARG NODEJS_VERSION=20

ENV DEBIAN_FRONTEND=noninteractive LANG=C.UTF-8 LC_ALL=C.UTF-8

# Configuration.
COPY bashrc /tmp
RUN cat /tmp/bashrc >> /etc/skel/.bashrc && rm /tmp/bashrc
COPY vimrc /etc/vim/vimrc.local
COPY termschool.vim /usr/share/vim/vim90/colors/termschool.vim
COPY gitconfig /etc/gitconfig
COPY mc.ini /etc/mc/mc.ini
RUN echo 'export PS1="\[\e[101;39m\] \u@\h \[\e[0m\]\[\e[103;30m\] \w \[\e[0m\]\n\[\e[01;30m\]$ \[\e[0m\]"' >> /root/.bashrc

RUN apt update && apt -y install sudo && \
    groupadd -g $USER_GID $USER_NAME && \
    useradd $USER_NAME -m -u $USER_UID -g $USER_GID -Gsudo -s /bin/bash && \
    echo $USER_NAME:$USER_PASSWORD | chpasswd

RUN touch /etc/sudoers.lecture && \
    echo 'Defaults lecture_file = /etc/sudoers.lecture' >> /etc/sudoers

RUN apt update && apt -y install \
    apt-utils \
    curl \
    zip \
    unzip \
    wget \
    apache2-utils \
    iputils-ping \
    net-tools \
    procps \
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
    bash-completion \
    redis-tools \
    mariadb-client \
    postgresql-client \
    gnupg && \
    mv /usr/bin/batcat /usr/bin/bat

COPY psqlrc /etc/postgresql-common/

# Install HR.
RUN wget -q https://raw.githubusercontent.com/LuRsT/hr/master/hr -O /usr/local/bin/hr && \
    chmod +x /usr/local/bin/hr

# Install Task.
RUN URL=$(curl -s /tmp https://api.github.com/repos/go-task/task/releases/latest | grep "browser_download_url.*task_linux_amd64\.deb" | cut -d : -f 2,3 | tr -d \") && \
    wget -q -P /tmp $URL && dpkg -i /tmp/task_linux_amd64.deb && rm /tmp/task_linux_amd64.deb

# Install mhsend
RUN wget --quiet https://github.com/mailhog/mhsendmail/releases/download/v0.2.0/mhsendmail_linux_amd64 && \
    chmod +x mhsendmail_linux_amd64 && \
    mv mhsendmail_linux_amd64 /usr/local/bin/mhsendmail

# Install Node JS
RUN mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODEJS_VERSION.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list && \
    apt update && apt install -y nodejs && \
    npm install --global yarn

USER wb
