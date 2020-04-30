FROM haproxy:alpine

ENV HAPROXY_USER haproxy
ENV KCP_VER 20200409
ENV HTTP_OVER_SOCKS_VER 0.0.7
ENV KCP_ARM_URL https://github.com/xtaci/kcptun/releases/download/v${KCP_VER}/kcptun-linux-arm7-${KCP_VER}.tar.gz
ENV KCP_AMD_URL https://github.com/xtaci/kcptun/releases/download/v${KCP_VER}/kcptun-linux-amd64-${KCP_VER}.tar.gz
ENV HTTP_OVER_SOCKS_ARM_URL https://github.com/colachg/http-over-socks/releases/download/v${HTTP_OVER_SOCKS_VER}/http-over-socks_${HTTP_OVER_SOCKS_VER}_linux_armv7.tar.gz
ENV HTTP_OVER_SOCKS_AMD_URL https://github.com/colachg/http-over-socks/releases/download/v${HTTP_OVER_SOCKS_VER}/http-over-socks_${HTTP_OVER_SOCKS_VER}_linux_amd64.tar.gz

RUN addgroup -S ${HAPROXY_USER} &&\
    adduser -S ${HAPROXY_USER} -G ${HAPROXY_USER} &&\
    mkdir --parents /var/lib/${HAPROXY_USER} /run/${HAPROXY_USER} && \
    chown -R ${HAPROXY_USER}:${HAPROXY_USER} /var/lib/${HAPROXY_USER}

RUN apk add --update curl supervisor &&\
    # Download kcptun
    curl -sSL $KCP_ARM_URL | tar xz -C /usr/bin/ client_linux_arm7 &&\
    curl -sSL $KCP_AMD_URL | tar xz -C /usr/bin/ client_linux_amd64 &&\
    curl -sSL $HTTP_OVER_SOCKS_ARM_URL| tar xz -C /usr/bin/ httpget_armv7 &&\
    curl -sSL $HTTP_OVER_SOCKS_AMD_URL| tar xz -C /usr/bin/ httpget_amd64

COPY supervisord.conf /etc/
COPY 01-kcptun.conf /etc/sysctl.d/
COPY haproxy.cfg /etc/
COPY checker.sh /usr/local/bin/

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord.conf"]
