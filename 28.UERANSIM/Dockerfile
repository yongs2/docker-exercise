FROM docker.io/ubuntu:20.04 as build

LABEL MAINTAINER=yongs2@hotmail.com

USER root
WORKDIR /root

# install dependency
RUN apt-get -y update \
    && apt-get -y install make g++ wget git libsctp-dev lksctp-tools iproute2

# install cmake, reference https://cmake.org/install/
ENV CMAKE_VERSION=3.19.5
RUN wget https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz --no-check-certificate \
    && tar zxf cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz
RUN cp -rf cmake-${CMAKE_VERSION}-Linux-x86_64/bin /usr/local/ \
    && cp -rf cmake-${CMAKE_VERSION}-Linux-x86_64/share /usr/local/

RUN git clone https://github.com/aligungr/UERANSIM
RUN ls -la /usr/local/bin/
RUN cd /root/UERANSIM \
    && make

# final stage
FROM docker.io/ubuntu:20.04

USER root
WORKDIR /root

# install dependency required at runtime
RUN apt-get -y update \
    && apt-get -y install libsctp-dev lksctp-tools iproute2

COPY --from=build /root/UERANSIM/build/ /root/UERANSIM/
COPY --from=build /root/UERANSIM/config/ /root/UERANSIM/config

# /root/UERANSIM/nr-gnb -c /root/UERANSIM/config/open5gs-gnb.yaml
# /root/UERANSIM/nr-ue -c /root/UERANSIM/config/open5gs-ue.yaml
CMD ["/root/UERANSIM/nr-gnb", "-c", "/root/UERANSIM/config/open5gs-gnb.yaml" ]
