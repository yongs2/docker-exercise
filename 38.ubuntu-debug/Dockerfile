FROM docker.io/ubuntu:22.04

USER root
WORKDIR /root

# install dependency required at runtime
RUN apt-get -y update \
    && apt-get -y install libsctp-dev lksctp-tools iproute2 iputils-ping
