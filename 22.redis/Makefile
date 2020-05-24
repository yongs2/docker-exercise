# https://redis.io/topics/cluster-tutorial
#

VERSION=5.0.9
#VERSION=6.0.0
#VERSION=6.0.3

.PHONY: network
network:
	docker network create ${NETWORK_NAME}

.PHONY: standalone
standalone:
	docker run -it --rm --name redis-standalone \
		-p 7001:7001 \
		-w /root \
		redis:${VERSION} \
		/bin/bash
		# redis-server --port 7001 --bind 0.0.0.0 &
		# apt-get update;apt-get install -y procps htop; htop

.PHONY: cluster
cluster:
	docker run -it --rm --name redis-cluster \
		-p 7001:7001 \
		-p 7002:7002 \
		-p 7003:7003 \
		-v `pwd`/run_redis_cluster.sh:/root/run_redis_cluster.sh \
		-w /root \
		redis:${VERSION} \
		/bin/bash
		# /root/run_redis_cluster.sh all
		# apt-get update;apt-get install -y procps htop; htop

.PHONY: redisbench
redisbench:
	docker run -it --rm --name golang \
		-e REDIS_HOST=172.17.0.2 \
		-v `pwd`/run_redisbench.sh:/root/run_redisbench.sh \
		golang:latest \
		/bin/bash
		# cd $GOPATH/src; git clone https://github.com/panjiang/redisbench
		# cd redisbench; 
		# go run . -cluster=true -a 172.17.0.2:7000,172.17.0.2:7001,172.17.0.3:7001 -c 10 -n 10 -d 1000
		
.PHONY: cli1
cli1:
	docker run --rm -it --name redis-cli1 \
		redis:${VERSION} \
		/bin/bash
