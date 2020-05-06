# https://mozi.tistory.com/377?category=1102290
# https://github.com/willbush/redis-failover-test/
#

CONTAINER_ID=$(shell docker ps --filter name=redis -q)
CONTAINER_IDS=$(shell docker ps --filter name=redis -q)
NETWORK_NAME=redis-network

.PHONY: network
network:
	docker network create ${NETWORK_NAME}

.PHONY: master
master:
	docker run --rm --name redis-master \
		--net=redis-network \
		-p 7000:6379 \
		-v `pwd`/master/redis.conf:/usr/local/etc/redis/redis.conf \
		-v `pwd`/master/data:/data \
		redis:latest \
		redis-server /usr/local/etc/redis/redis.conf


.PHONY: slave1
slave1:
	docker run --rm --name redis-slave1 \
		--net=redis-network \
		-v `pwd`/slave1/redis.conf:/usr/local/etc/redis/redis.conf \
		-v `pwd`/slave1/data:/data \
		-p 7001:6379 \
		redis:latest \
		redis-server /usr/local/etc/redis/redis.conf

# apt-get -y update;apt-get -y install iputils-ping net-tools
.PHONY: cli1
cli1:
	docker run --rm -it --name redis-cli1 \
		--net=redis-network \
		-v `pwd`/slave1/redis.conf:/usr/local/etc/redis/redis.conf \
		-v `pwd`/slave1/data:/data \
		-p 7002:6379 \
		redis:latest \
		/bin/bash

.PHONY: sentinel1
sentinel1:
	/bin/cp ./sentinel/sentinel.conf ./sentinel/sentinel1.conf
	docker run --rm --name redis-sentinel1 \
		--net=redis-network \
		-v `pwd`/sentinel/sentinel1.conf:/usr/local/etc/sentinel/sentinel.conf \
		-p 8001:26379 \
		redis:latest \
		redis-server /usr/local/etc/sentinel/sentinel.conf --sentinel

.PHONY: sentinel2
sentinel2:
	/bin/cp ./sentinel/sentinel.conf ./sentinel/sentinel2.conf
	docker run --rm --name redis-sentinel2 \
		--net=redis-network \
		-v `pwd`/sentinel/sentinel2.conf:/usr/local/etc/sentinel/sentinel.conf \
		-p 8002:26379 \
		redis:latest \
		redis-server /usr/local/etc/sentinel/sentinel.conf --sentinel

.PHONY: sentinel3
sentinel3:
	/bin/cp ./sentinel/sentinel.conf ./sentinel/sentinel3.conf
	docker run --rm --name redis-sentinel3 \
		--net=redis-network \
		-v `pwd`/sentinel/sentinel3.conf:/usr/local/etc/sentinel/sentinel.conf \
		-p 8003:26379 \
		redis:latest \
		redis-server /usr/local/etc/sentinel/sentinel.conf --sentinel

.PHONY: stop
stop:
	#docker stop ${CONTAINER_IDS}
	#docker rm ${CONTAINER_IDS}
	docker network rm ${NETWORK_NAME}
	/bin/rm -f ./sentinel/sentinel?.conf

client0:
	docker run -it --rm --name redis-client0 \
		--net=redis-network \
		redis:latest \
		redis-cli -h redis-master -p 6379

client1:
	docker run -it --rm --name redis-client1 \
		--net=redis-network \
		redis:latest \
		redis-cli -h redis-slave1 -p 6379
