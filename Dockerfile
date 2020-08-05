FROM haproxy:alpine

ENV HAPROXY_USER haproxy
ENV KCP_VER 20200701
ENV TROJAN_GO_VER 0.5.0
ENV HTTP_OVER_SOCKS_VER 0.0.7
ENV DNSCRYPT_PROXY_VER 2.0.42

RUN addgroup -S ${HAPROXY_USER} &&\
    adduser -S ${HAPROXY_USER} -G ${HAPROXY_USER} &&\
    mkdir --parents /var/lib/${HAPROXY_USER} /run/${HAPROXY_USER} && \
    chown -R ${HAPROXY_USER}:${HAPROXY_USER} /var/lib/${HAPROXY_USER}

COPY build.sh /
RUN sh build.sh

COPY supervisord.conf /etc/
COPY 01-kcptun.conf /etc/sysctl.d/
COPY haproxy.cfg /etc/
COPY checker.sh /usr/local/bin/

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
