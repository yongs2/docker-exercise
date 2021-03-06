# https://redis.io/topics/cluster-tutorial
#

CONTAINER_ID=$(shell docker ps --filter name=redis -q)
CONTAINER_IDS=$(shell docker ps --filter name=redis -q)
NETWORK_NAME=redis-network

.PHONY: network
network:
	docker network create ${NETWORK_NAME}

.PHONY: node1
node1:
	docker run -it --rm --name redis-node1 \
		--net=${NETWORK_NAME} \
		-p 7101:7001 \
		-p 7102:7002 \
		-p 7103:7003 \
		-p 27101:27001 \
		-p 27102:27002 \
		-p 27103:27003 \
		-v `pwd`/node1:/data \
		redis:latest \
		/bin/bash

.PHONY: node2
node2:
	docker run -it --rm --name redis-node2 \
		--net=${NETWORK_NAME} \
		-p 7201:7001 \
		-p 7202:7002 \
		-p 7203:7003 \
		-p 27201:27001 \
		-p 27202:27002 \
		-p 27203:27003 \
		-v `pwd`/node2:/data \
		redis:latest \
		/bin/bash

.PHONY: node3
node3:
	docker run -it --rm --name redis-node3 \
		--net=${NETWORK_NAME} \
		-p 7301:7001 \
		-p 7302:7002 \
		-p 7303:7003 \
		-p 27301:27001 \
		-p 27302:27002 \
		-p 27303:27003 \
		-v `pwd`/node3:/data \
		redis:latest \
		/bin/bash

.PHONY: stop
stop:
	#docker stop ${CONTAINER_IDS}
	#docker rm ${CONTAINER_IDS}
	docker network rm ${NETWORK_NAME}

# apt-get -y update;apt-get -y install iputils-ping net-tools
.PHONY: cli1
cli1:
	docker run --rm -it --name redis-cli1 \
		--net=${NETWORK_NAME} \
		redis:latest \
		/bin/bash
		# redis-cli -h redis-node1 -p 7001
		# redis-cli -h redis-node2 -p 7001
		# redis-cli -h redis-node3 -p 7001
		# info replication

.PHONY: haproxy1
haproxy1:
	docker run -d --rm --name haproxy1 \
		--net=${NETWORK_NAME} \
		-p 5000:5000 \
		-p 5001:5001 \
		-p 16999:6999 \
		-v `pwd`/haproxy1/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg \
		haproxy:2.1.7-alpine

.PHONY: haproxy1-it
haproxy1-it:
	docker run -it --rm --name haproxy1-it \
		--net=${NETWORK_NAME} \
		-p 5000:5000 \
		-p 5001:5001 \
		-p 16999:6999 \
		-v `pwd`/haproxy1/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg \
		haproxy:2.1.7-alpine \
		/bin/sh

.PHONY: redisbench-build
redisbench-build:
	docker build -t redisbench -f redisbench/Dockerfile redisbench/

# 1. Direct
# /redisbench -a redis-node1:7001 -c 10 -d 1000 -n 100
.PHONY: redisbench-direct
redisbench-direct:
	docker run -it --rm --name redisbench \
		--net=${NETWORK_NAME} \
		redisbench:latest \
		/bin/bash -c "for i in {1..10}; do /redisbench -a redis-node1:7001 -c 10 -d 1000 -n 100 2>&1 | egrep -i 'TPS' ; done"

# 2. haproxy
# /redisbench -a haproxy1:5000 -c 10 -d 1000 -n 100
.PHONY: redisbench-haproxy
redisbench-haproxy:
	docker run -it --rm --name redisbench \
		--net=${NETWORK_NAME} \
		redisbench:latest \
		/bin/bash -c "for i in {1..10}; do /redisbench -a haproxy1:5000 -c 10 -d 1000 -n 100 2>&1 | egrep -i 'TPS' ; done"
