FROM debian:bullseye

#--------------------
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=C.UTF-8 \
    LC_ALL=C.UTF-8

RUN apt-get update

#--------------------
COPY playbook.sh /usr/bin/playbook
COPY playbooks /usr/lib/playbooks
RUN mkdir /root/start /root/stop

#--------------------
RUN playbook base

#--------------------
COPY cmd.sh /root/cmd.sh
RUN chmod +x /root/cmd.sh
CMD ["/root/cmd.sh"]
