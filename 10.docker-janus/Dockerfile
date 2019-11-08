FROM centos:7
LABEL mainterner yongs2@hotmail.com

RUN yum -y install epel-release \
    && yum -y update \
    && yum -y groupinstall "Development Tools" \
    && yum -y install libmicrohttpd-devel jansson-devel libnice* \
        openssl-devel libsrtp-devel sofia-sip-devel libglib2.0-dev \
        opus-devel libogg-devel libcurl-devel lua-devel libconfig-devel \
        pkgconfig gengetopt libtool autoconf automake git cmake wget make npm which openssl

WORKDIR /root

# libsrtp
RUN mkdir /root/libsrtp \
    && cd /root/libsrtp \
    && wget https://github.com/cisco/libsrtp/archive/v2.2.0.tar.gz \
    && tar xfv v2.2.0.tar.gz \
    && cd libsrtp-2.2.0 \
    && ./configure --prefix=/usr --enable-openssl \
    && make shared_library &&  make install 

# libsctp
RUN cd /root/ \
    && git clone https://github.com/sctplab/usrsctp \
    && cd /root/usrsctp \
    && ./bootstrap \
    && ./configure --prefix=/usr && make &&  make install

# Websocket
RUN cd /root/ \
    && git clone https://github.com/warmcat/libwebsockets.git \
    && cd libwebsockets \
    && mkdir build \
    && cd build \
    && cmake -DLWS_MAX_SMP=1 -DCMAKE_INSTALL_PREFIX:PATH=/usr -DCMAKE_C_FLAGS="-fpic" .. \
    && make &&  make install

# janus-gateway
RUN cd /root/ \
    && git clone https://github.com/meetecho/janus-gateway.git \
    && cd janus-gateway \
    && sh autogen.sh \
    && ./configure --prefix=/opt/janus --disable-rabbitmq --disable-mqtt \
    && make \
    && make install \
    && make configs

ADD startup.sh /root/startup.sh
ADD make-private-cert.sh /root/make-private-cert.sh

ENV PATH=/opt/janus/bin:${PATH}
ENV LD_LIBRARY_PATH=/usr/lib:/opt/janus/lib:/opt/janus/lib/janus/transports:/opt/janus/lib/janus/plugins:${LD_LIBRARY_PATH}

RUN cd /root/ \
    && chmod +x /root/*.sh \
    && /root/make-private-cert.sh \
    && npm install -g http-server 

CMD ["/root/startup.sh"]

EXPOSE 80 443 8080 8088 8089 8889 8000 7088 7089 10000-10200
