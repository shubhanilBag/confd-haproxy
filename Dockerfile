FROM haproxy:1.9

ARG CONFD_VERSION=0.16.0
ARG CONFD_USER=root
ARG CONFD_GROUP=root

RUN groupadd -g 99 nobody \
    && usermod -u 99 -g 99 -c 'Nobody for RHEL based system' nobody \
    && echo "nobody:x:65534:65534:Nobody for Debian based system:/nonexistance:/sbin/nologin" >> /etc/passwd \
    && usermod -a -G users nobody

ADD https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64 /tmp/

RUN mkdir -p /etc/confd/conf.d /etc/confd/templates /var/run/haproxy

RUN apt-get update && apt-get install -y curl

RUN mv /tmp/confd-${CONFD_VERSION}-linux-amd64 /usr/local/bin/confd \
    && chmod +x /usr/local/bin/confd

COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg
COPY haproxy.toml /etc/confd/conf.d/haproxy.toml
COPY haproxy.tmpl /etc/confd/templates/haproxy.tmpl

RUN chown -R ${CONFD_USER}:${CONFD_GROUP} /usr/local/etc/haproxy /etc/confd /var/run/haproxy \
    && chmod -R g+w /usr/local/etc/haproxy /etc/confd /var/run/haproxy
