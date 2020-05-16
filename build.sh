#!/bin/sh
apk add --update curl supervisor

if [ `uname -m` = x86_64 ]
then
    KCP_URL=https://github.com/xtaci/kcptun/releases/download/v${KCP_VER}/kcptun-linux-amd64-${KCP_VER}.tar.gz
    HTTP_OVER_SOCKS_URL=https://github.com/colachg/http-over-socks/releases/download/v${HTTP_OVER_SOCKS_VER}/http-over-socks_${HTTP_OVER_SOCKS_VER}_linux_amd64.tar.gz
    TROJAN_GO_URL=https://github.com/p4gefau1t/trojan-go/releases/download/v${TROJAN_GO_VER}/trojan-go-linux-amd64.zip
    curl -sSL $KCP_URL | tar xz -C /usr/bin/ client_linux_amd64
    curl -sSL $HTTP_OVER_SOCKS_URL| tar xz -C /usr/bin/ httpget
    wget $TROJAN_GO_URL
    mkdir trojan-go
    unzip trojan-go-linux-amd64.zip -d trojan-go
    mv trojan-go/trojan-go trojan-go/geoip.dat trojan-go/geosite.dat /usr/bin/
    rm -rf trojan-go-linux-amd64.zip trojan-go
    mkdir /tmp/repo
    wget --no-check-certificate https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.31-r0/glibc-2.31-r0.apk -P /tmp/repo/
    apk add --repositories-file=/dev/null --allow-untrusted --no-network --no-cache /tmp/repo/glibc-2.31-r0.apk
    rm -rf /tmp/repo/2.31-r0/glibc-2.31-r0.apk
fi

# RaspberryPi 3B+
if [ `uname -m` = armv7l ]
then
    KCP_URL=https://github.com/xtaci/kcptun/releases/download/v${KCP_VER}/kcptun-linux-arm7-${KCP_VER}.tar.gz
    HTTP_OVER_SOCKS_URL=https://github.com/colachg/http-over-socks/releases/download/v${HTTP_OVER_SOCKS_VER}/http-over-socks_${HTTP_OVER_SOCKS_VER}_linux_armv7.tar.gz
    TROJAN_GO_URL=https://github.com/p4gefau1t/trojan-go/releases/download/v${TROJAN_GO_VER}/trojan-go-linux-arm.zip
    curl -sSL $KCP_URL | tar xz -C /usr/bin/ client_linux_arm7
    curl -sSL $HTTP_OVER_SOCKS_URL| tar xz -C /usr/bin/ httpget
    wget $TROJAN_GO_URL
    mkdir trojan-go
    unzip trojan-go-linux-arm.zip -d trojan-go
    mv trojan-go/trojan-go trojan-go/geoip.dat trojan-go/geosite.dat /usr/bin/
    rm -rf trojan-go-linux-arm.zip trojan-go
fi

# RaspberryPi 4
if [ `uname -m` = aarch64 ]
then
    KCP_URL=https://github.com/xtaci/kcptun/releases/download/v${KCP_VER}/kcptun-linux-arm64-${KCP_VER}.tar.gz
#     HTTP_OVER_SOCKS_URL=https://github.com/colachg/http-over-socks/releases/download/v${HTTP_OVER_SOCKS_VER}/http-over-socks_${HTTP_OVER_SOCKS_VER}_linux_armv7.tar.gz
    TROJAN_GO_URL=https://github.com/p4gefau1t/trojan-go/releases/download/v${TROJAN_GO_VER}/trojan-go-linux-arm64.zip
    curl -sSL $KCP_URL | tar xz -C /usr/bin/ client_linux_arm64
#     curl -sSL $HTTP_OVER_SOCKS_URL| tar xz -C /usr/bin/ httpget
    wget $TROJAN_GO_URL
    mkdir trojan-go
    unzip trojan-go-linux-arm64.zip -d trojan-go
    mv trojan-go/trojan-go trojan-go/geoip.dat trojan-go/geosite.dat /usr/bin/
    rm -rf trojan-go-linux-arm64.zip trojan-go
fi
