# https://redis.io/topics/cluster-tutorial
#

CONTAINER_ID=$(shell docker ps --filter name=redis -q)
CONTAINER_IDS=$(shell docker ps --filter name=redis -q)
NETWORK_NAME=redis-network

.PHONY: network
network:
	docker network create ${NETWORK_NAME}

.PHONY: cluster1
cluster1:
	docker run --rm --name redis-cluster1 \
		--net=${NETWORK_NAME} \
		-p 7000:6379 \
		-v `pwd`/redis.conf:/usr/local/etc/redis/redis.conf \
		redis:latest \
		redis-server /usr/local/etc/redis/redis.conf

.PHONY: cluster2
cluster2:
	docker run --rm --name redis-cluster2 \
		--net=${NETWORK_NAME} \
		-v `pwd`/redis.conf:/usr/local/etc/redis/redis.conf \
		-p 7001:6379 \
		redis:latest \
		redis-server /usr/local/etc/redis/redis.conf

.PHONY: cluster3
cluster3:
	docker run --rm -it --name redis-cluster3 \
		--net=${NETWORK_NAME} \
		-v `pwd`/redis.conf:/usr/local/etc/redis/redis.conf \
		-p 7002:6379 \
		redis:latest \
		redis-server /usr/local/etc/redis/redis.conf

.PHONY: stop
stop:
	#docker stop ${CONTAINER_IDS}
	#docker rm ${CONTAINER_IDS}
	docker network rm ${NETWORK_NAME}
	/bin/rm -f ./sentinel/sentinel?.conf

.PHONY: create_cluster
create_cluster:
	$(eval IP1=$(shell docker exec redis-cluster1 hostname -i))
	$(eval IP2=$(shell docker exec redis-cluster2 hostname -i))
	$(eval IP3=$(shell docker exec redis-cluster3 hostname -i))
	docker run -it --rm --name redis-create_cluster \
		--net=${NETWORK_NAME} \
		redis:latest \
		redis-cli --cluster create $(IP1):6379 $(IP2):6379 $(IP3):6379

# redis-cli --cluster create 172.25.0.2:6379 172.25.0.3:6379 172.25.0.4:6379 
# apt-get -y update;apt-get -y install iputils-ping net-tools
.PHONY: cli1
cli1:
	docker run --rm -it --name redis-cli1 \
		--net=${NETWORK_NAME} \
		redis:latest \
		/bin/bash

.PHONY: client1
client1:
	docker run -it --rm --name redis-client1 \
		--net=${NETWORK_NAME} \
		redis:latest \
		redis-cli -c -h redis-cluster1 -p 6379

.PHONY: client2
client2:
	docker run -it --rm --name redis-client2 \
		--net=${NETWORK_NAME} \
		redis:latest \
		redis-cli -c -h redis-cluster2 -p 6379
