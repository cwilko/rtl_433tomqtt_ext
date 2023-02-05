# https://hub.docker.com/layers/bademux/rtl_433tomqtt/0.0.5/images/sha256-b0541ead69a5c27dbd44c4a2b4741eb0435c34e76e5c4943e8c32ab3d7226844?context=explore

FROM bademux/rtl_433tomqtt:0.2.1

WORKDIR /tmp
RUN apk add --no-cache --virtual .build-deps git bash cmake build-base autoconf automake libtool
RUN apk add --no-cache libstdc++ fftw fftw-dev --repository https://dl-3.alpinelinux.org/alpine/edge/testing

# Install kalibrate-rtl
RUN git clone https://github.com/asdil12/kalibrate-rtl.git && \
    cd kalibrate-rtl && \
    git checkout arm_memory

RUN ./bootstrap && \
    LIBRTLSDR_LIBS=-lrtlsdr CXXFLAGS='-W -Wall -O3' ./configure && \
    LIBRTLSDR_LIBS=-lrtlsdr make && \
    make install

RUN apk del .build-deps