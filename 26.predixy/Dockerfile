FROM docker.io/centos:centos8.2.2004

LABEL MAINTAINER=yongs2@hotmail.com

USER root
WORKDIR /root

# install prefixy
ENV VERSION 1.0.5
RUN curl -LO https://github.com/joyieldInc/predixy/releases/download/${VERSION}/predixy-${VERSION}-bin-amd64-linux.tar.gz \
    && tar -zxvf predixy-${VERSION}-bin-amd64-linux.tar.gz \
    && cd predixy-${VERSION} \
    && cp bin/predixy /usr/local/bin \
    && mkdir -p /etc/predixy/conf

ADD conf /etc/predixy/conf

CMD ["/usr/local/bin/predixy", "/etc/predixy/conf/predixy.conf"]
