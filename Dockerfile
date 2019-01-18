FROM haproxy:1.9

ARG CONFD_VERSION=0.16.0

ADD https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64 /tmp/

RUN mkdir -p /etc/confd/conf.d /etc/confd/templates

RUN apt-get update && apt-get install -y curl

RUN mv /tmp/confd-0.16.0-linux-amd64 /usr/local/bin/confd && \
    chmod +x /usr/local/bin/confd

COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
COPY haproxy.toml /etc/confd/conf.d/haproxy.toml
COPY haproxy.tmpl /etc/confd/templates/haproxy.tmpl
