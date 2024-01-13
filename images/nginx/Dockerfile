FROM debian:bookworm-slim

RUN echo 'export PS1="\[\e[101;39m\] \u@\H \[\e[0m\]\[\e[103;30m\] \w \[\e[0m\]\n\[\e[01;30m\]$ \[\e[0m\]"' >> /root/.bashrc

RUN apt update && apt -y install nginx ca-certificates

# Forward request and error logs to docker log collector.
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

COPY create-cert.sh /usr/lib/create-cert.sh
RUN /usr/lib/create-cert.sh

CMD ["nginx", "-g", "daemon off;"]
