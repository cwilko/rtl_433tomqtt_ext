# Grab armv7 base image
FROM bademux/rtl_433tomqtt@sha256:b0541ead69a5c27dbd44c4a2b4741eb0435c34e76e5c4943e8c32ab3d7226844

WORKDIR /tmp
RUN apk add --no-cache --virtual .build-deps git bash cmake build-base autoconf automake libtool && \
    apk add --no-cache fftw fftw-dev --repository https://dl-3.alpinelinux.org/alpine/edge/testing/ && \

    # Install kalibrate-rtl
    git clone https://github.com/steve-m/kalibrate-rtl.git && \
    cd kalibrate-rtl && \
    ./bootstrap && \
    LIBRTLSDR_CFLAGS=-lrtlsdr CXXFLAGS='-W -Wall -O3' ./configure && \
    make && \
    make install && \

    apk del .build-deps