FROM docker.io/centos:centos8.2.2004

LABEL MAINTAINER=yongs2@hotmail.com

USER root
WORKDIR /root

# install redis-cluster-proxy
RUN dnf -y install gcc make git

RUN git clone https://github.com/RedisLabs/redis-cluster-proxy \
    && cd redis-cluster-proxy \
    && make \
    && make install

CMD ["/usr/local/bin/redis-cluster-proxy", "--port", "7888", "127.0.0.1:7000"]
