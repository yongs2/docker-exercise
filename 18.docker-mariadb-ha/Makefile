# https://github.com/mariadb-faisalsaeed/mariadb-ha-setup/

CONTAINER_ID=$(shell docker ps --filter name=mariadb -q)
CONTAINER_IDS=$(shell docker ps --filter name=mariadb -q)
NETWORK_NAME=mariadb-network

DB_USER=agent
DB_PASS=agent.123

.PHONY: network
network:
	docker network ls
	docker network create ${NETWORK_NAME}

.PHONY: mariadb1
mariadb1:
	docker run --rm --name mariadb1 \
		--net=${NETWORK_NAME} \
		-p 3301:3306 \
		-e MYSQL_ROOT_PASSWORD=password \
		-v `pwd`/master-initdb.d:/docker-entrypoint-initdb.d \
		-v `pwd`/config/my1.utf8.cnf:/etc/mysql/my.cnf \
		mariadb:latest

.PHONY: mariadb2
mariadb2:
	docker run --rm --name mariadb2 \
		--net=${NETWORK_NAME} \
		-p 3302:3306 \
		-e MYSQL_ROOT_PASSWORD=password \
		-v `pwd`/slave-initdb.d:/docker-entrypoint-initdb.d \
		-v `pwd`/config/my2.utf8.cnf:/etc/mysql/my.cnf \
		mariadb:latest

.PHONY: maxscale1
maxscale1:
	docker run --rm --name maxscale1 \
		--net=${NETWORK_NAME} \
		-p 4401:4406 \
		-e MYSQL_ROOT_PASSWORD=password \
		-v `pwd`/config/maxscale.cnf:/etc/maxscale.cnf \
		mariadb/maxscale:latest

.PHONY: maxscale2
maxscale2:
	docker run --rm --name maxscale2 \
		--net=${NETWORK_NAME} \
		-p 4402:4406 \
		-e MYSQL_ROOT_PASSWORD=password \
		-v `pwd`/config/maxscale.cnf:/etc/maxscale.cnf \
		mariadb/maxscale:latest

.PHONY: cli
cli:
	docker run --rm -it --name mariadb-cli \
		--net=${NETWORK_NAME} \
		mariadb:latest /bin/bash

.PHONY: cli1
cli1:
	docker run --rm -it --name mariadb-cli1 \
		--net=${NETWORK_NAME} \
		mariadb:latest mysql -h mariadb1 -u ${DB_USER} -p${DB_PASS}

.PHONY: cli2
cli2:
	docker run --rm -it --name mariadb-cli2 \
		--net=${NETWORK_NAME} \
		mariadb:latest mysql -h mariadb2 -u ${DB_USER} -p${DB_PASS}

.PHONY: stop
stop:
	docker stop ${CONTAINER_IDS}
	docker rm ${CONTAINER_IDS}
	docker network rm ${NETWORK_NAME}
