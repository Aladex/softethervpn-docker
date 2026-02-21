ARG COMPONENT=server
ARG SOFTETHER_TAG=

FROM alpine AS builder

ARG SOFTETHER_TAG

RUN mkdir /usr/local/src && apk add --no-cache \
        binutils \
        build-base \
        readline-dev \
        openssl-dev \
        ncurses-dev \
        git \
        cmake \
        zlib-dev \
        libsodium-dev \
        gnu-libiconv \
        linux-headers

ENV LD_PRELOAD=/usr/lib/preloadable_libiconv.so
ENV USE_MUSL=YES

WORKDIR /usr/local/src

RUN if [ -n "$SOFTETHER_TAG" ]; then \
        git clone -b "$SOFTETHER_TAG" --depth 1 https://github.com/SoftEtherVPN/SoftEtherVPN.git; \
    else \
        git clone --depth 1 https://github.com/SoftEtherVPN/SoftEtherVPN.git; \
    fi

RUN cd SoftEtherVPN && \
    git submodule init && \
    git submodule update && \
    ./configure && \
    make -C build

FROM alpine

ARG COMPONENT

RUN apk add --no-cache \
        readline \
        openssl \
        libsodium \
        gnu-libiconv \
        iptables

ENV LD_PRELOAD=/usr/lib/preloadable_libiconv.so
ENV LD_LIBRARY_PATH=/root

WORKDIR /usr/local/bin
VOLUME /mnt

RUN ln -s /mnt/vpn_${COMPONENT}.config vpn_${COMPONENT}.config && \
    mkdir /mnt/backup.vpn_${COMPONENT}.config && \
    ln -s /mnt/backup.vpn_${COMPONENT}.config backup.vpn_${COMPONENT}.config && \
    ln -s /mnt/lang.config lang.config

COPY --from=builder /usr/local/src/SoftEtherVPN/build/vpn${COMPONENT} ./
COPY --from=builder /usr/local/src/SoftEtherVPN/build/vpncmd ./
COPY --from=builder /usr/local/src/SoftEtherVPN/build/hamcore.se2 ./
COPY --from=builder /usr/local/src/SoftEtherVPN/build/libcedar.so /usr/local/src/SoftEtherVPN/build/libmayaqua.so ./
COPY --from=builder /usr/local/src/SoftEtherVPN/build/libcedar.so /usr/local/src/SoftEtherVPN/build/libmayaqua.so /usr/local/lib/

ENV COMPONENT=${COMPONENT}

CMD /usr/local/bin/vpn${COMPONENT} execsvc
