FROM haproxy:alpine

ENV HAPROXY_USER haproxy
ENV KCP_VER 20210103
ENV DNSCRYPT_PROXY_VER 2.0.45

RUN mkdir --parents /var/lib/${HAPROXY_USER} /run/${HAPROXY_USER} && \
    chown -R ${HAPROXY_USER}:${HAPROXY_USER} /var/lib/${HAPROXY_USER}

COPY build.sh /
RUN sh build.sh

COPY supervisord.conf /etc/
COPY 01-kcptun.conf /etc/sysctl.d/
COPY haproxy.cfg /etc/

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
