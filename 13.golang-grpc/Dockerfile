FROM golang:latest

LABEL MAINTAINER=yongs2@hotmail.com

USER root

# install grpc
RUN apt-get update; apt-get -y install build-essential autoconf libtool pkg-config vim;
RUN cd ~/ \
    && git clone -b $(curl -L https://grpc.io/release) https://github.com/grpc/grpc \
    && cd ~/grpc \
    && git submodule update --init \
    && sed -i 's/-Werror/-Wno-tautological-compare -Wno-ignored-qualifiers/g' Makefile \
    && make; make install \
    && cd ~/grpc/third_party/protobuf \
    && make; make install

# install protoc-gen-go and gomock
RUN go get -d -u github.com/golang/protobuf/protoc-gen-go \
    && go install github.com/golang/protobuf/protoc-gen-go \
    && go get github.com/golang/mock/mockgen 
