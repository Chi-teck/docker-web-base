ARG POSTGRES_VERSION

FROM postgres:${POSTGRES_VERSION}-bookworm

RUN echo 'export PS1="\[\e[101;39m\] \u@\h \[\e[0m\]\[\e[103;30m\] \w \[\e[0m\]\n\[\e[01;30m\]$ \[\e[0m\]"' >> /root/.bashrc
