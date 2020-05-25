#!/bin/sh

# install utils
#apt-get -y update;apt-get -y install iputils-ping net-tools procps;

# run redis-node1 - master
redis-server --port 7001 --bind 0.0.0.0 &

# run redis-node3 - slave1
redis-server --port 7002 --bind 0.0.0.0 --replicaof redis-node3 7001 &

# run redis-node2 - slave2
redis-server --port 7003 --bind 0.0.0.0 --replicaof redis-node2 7001 &

# copy config
cp /data/*.conf /etc/

# run redis-node1 - sentinel1
redis-server /etc/redis-node1-sentinel1.conf --sentinel &

# run redis-node3 - sentinel2
redis-server /etc/redis-node3-sentinel2.conf --sentinel &

# run redis-node2 - sentinel3
redis-server /etc/redis-node2-sentinel3.conf --sentinel &
