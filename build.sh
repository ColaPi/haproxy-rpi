#!/bin/sh
apk add --update curl supervisor

if [ `uname -m` = x86_64 ]
then
    KCP_URL=https://github.com/xtaci/kcptun/releases/download/v${KCP_VER}/kcptun-linux-amd64-${KCP_VER}.tar.gz
    HTTP_OVER_SOCKS_URL=https://github.com/colachg/http-over-socks/releases/download/v${HTTP_OVER_SOCKS_VER}/http-over-socks_${HTTP_OVER_SOCKS_VER}_linux_amd64.tar.gz
    curl -sSL $KCP_URL | tar xz -C /usr/bin/ client_linux_amd64
    curl -sSL $HTTP_OVER_SOCKS_URL| tar xz -C /usr/bin/ httpget
fi

if [ `uname -m` = armv7l ]
then
    KCP_URL=https://github.com/xtaci/kcptun/releases/download/v${KCP_VER}/kcptun-linux-arm7-${KCP_VER}.tar.gz
    HTTP_OVER_SOCKS_URL=https://github.com/colachg/http-over-socks/releases/download/v${HTTP_OVER_SOCKS_VER}/http-over-socks_${HTTP_OVER_SOCKS_VER}_linux_armv7.tar.gz
    curl -sSL $KCP_URL | tar xz -C /usr/bin/ client_linux_arm7
    curl -sSL $HTTP_OVER_SOCKS_URL| tar xz -C /usr/bin/ httpget
fi

