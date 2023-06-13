FROM debian:bookworm

#--------------------
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

#RUN sed -i 's/stable\/updates/stable-security\/updates/' /etc/apt/sources.list

#--------------------
COPY playbook.sh /usr/bin/playbook
COPY playbooks /usr/lib/playbooks
RUN mkdir /root/start /root/stop

#--------------------
COPY base /tmp/base
RUN /tmp/base/install.sh && rm -r /tmp/base

#--------------------
COPY cmd.sh /root/cmd.sh
CMD ["/root/cmd.sh"]
