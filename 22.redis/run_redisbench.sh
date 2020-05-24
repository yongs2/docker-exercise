#!/bin/sh

REDIS_HOST=172.17.0.2

cd $GOPATH/src;
git clone https://github.com/panjiang/redisbench
cd $GOPATH/src/redisbench; 
go run . -cluster=true -a ${REDIS_HOST}:7000,${REDIS_HOST}:7001,${REDIS_HOST}:7002 -c 10 -n 10 -d 1000
