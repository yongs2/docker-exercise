# https://mozi.tistory.com/377?category=1102290
# https://github.com/willbush/redis-failover-test/
#

CONTAINER_ID=$(shell docker ps --filter name=redis -q)
CONTAINER_IDS=$(shell docker ps --filter name=redis -q)

.PHONY: master
master:
	docker run --rm --name redis-master \
		-p 7000:6379 \
		-v `pwd`/master/redis.conf:/usr/local/etc/redis/redis.conf \
		-v `pwd`/master/data:/data \
		redis:latest \
		redis-server /usr/local/etc/redis/redis.conf


.PHONY: slave1
slave1:
	docker run --rm --name redis-slave1 \
		--link redis-master:redis-master \
		-v `pwd`/slave1/redis.conf:/usr/local/etc/redis/redis.conf \
		-v `pwd`/slave1/data:/data \
		-p 7001:6379 \
		redis:latest \
		redis-server /usr/local/etc/redis/redis.conf

.PHONY: stop
stop:
	docker stop ${CONTAINER_IDS}
	docker rm ${CONTAINER_IDS}

client0:
	docker run -it --rm --name redis-client0 \
		--link redis-master:redis-master \
		redis:latest \
		redis-cli -h redis-master -p 6379


client1:
	docker run -it --rm --name redis-client1 \
		--link redis-slave1:redis-slave1 \
		redis:latest \
		redis-cli -h redis-slave1 -p 6379
