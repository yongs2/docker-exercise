# https://hub.docker.com/r/bitnami/mariadb-galera
# https://github.com/bitnami/bitnami-docker-mariadb-galera
#
GALERA_NODE_NAME=mariadb-galera
CLUSTER_NAME=my_galera
MARIABACKUP_USER=my_mariabackup_user
MARIABACKUP_PASSWORD=my_mariabackup_password
ROOT_PASSWORD=my_root_password
MARIADB_USER=my_user
MARIADB_PASSWORD=my_password
MARIADB_DATABASE=my_database

CONTAINER_ID=$(shell docker ps --filter name=mariadb-galera-0 -q)
CONTAINER_IDS=$(shell docker ps --filter name=mariadb-galera -q)

.PHONY: bootstrap
bootstrap:
	docker run --rm --name ${GALERA_NODE_NAME}-0 \
		-e MARIADB_GALERA_CLUSTER_BOOTSTRAP=yes \
		-e MARIADB_GALERA_CLUSTER_NAME=${CLUSTER_NAME} \
		-e MARIADB_GALERA_MARIABACKUP_USER=${MARIABACKUP_USER} \
		-e MARIADB_GALERA_MARIABACKUP_PASSWORD=${MARIABACKUP_PASSWORD} \
		-e MARIADB_ROOT_PASSWORD=${ROOT_PASSWORD} \
		-e MARIADB_USER=${MARIADB_USER} \
		-e MARIADB_PASSWORD=${MARIADB_PASSWORD} \
		-e MARIADB_DATABASE=${MARIADB_DATABASE} \
		-p 3306:3306 \
		-p 4444:4444 \
		-p 4567:4567 \
		-p 4568:4568 \
		bitnami/mariadb-galera:latest

.PHONY: node1
node1:
	docker run --rm --name ${GALERA_NODE_NAME}-1 --link ${GALERA_NODE_NAME}-0:mariadb-galera \
		-e MARIADB_GALERA_CLUSTER_NAME=${CLUSTER_NAME} \
		-e MARIADB_GALERA_CLUSTER_ADDRESS=gcomm://mariadb-galera \
		-e MARIADB_GALERA_MARIABACKUP_USER=${MARIABACKUP_USER} \
		-e MARIADB_GALERA_MARIABACKUP_PASSWORD=${MARIABACKUP_PASSWORD} \
		bitnami/mariadb-galera:latest

.PHONY: node2
node2:
	docker run --rm --name ${GALERA_NODE_NAME}-2 --link ${GALERA_NODE_NAME}-0:mariadb-galera \
		-e MARIADB_GALERA_CLUSTER_NAME=${CLUSTER_NAME} \
		-e MARIADB_GALERA_CLUSTER_ADDRESS=gcomm://mariadb-galera \
		-e MARIADB_GALERA_MARIABACKUP_USER=${MARIABACKUP_USER} \
		-e MARIADB_GALERA_MARIABACKUP_PASSWORD=${MARIABACKUP_PASSWORD} \
		bitnami/mariadb-galera:latest

.PHONY: status
status:
	docker exec -it ${CONTAINER_ID} mysql -uroot -pmy_root_password \
-e"SELECT * FROM information_schema.global_status WHERE variable_name IN ('WSREP_CLUSTER_STATUS','WSREP_LOCAL_STATE_COMMENT','WSREP_CLUSTER_SIZE','WSREP_EVS_DELAYED','WSREP_READY','WSREP_INCOMING_ADDRESSES');"
	#IDS=$(docker ps --filter name=${GALERA_NODE_NAME} -q)

.PHONY: stop
stop:
	docker stop ${CONTAINER_IDS}
	docker rm ${CONTAINER_IDS}

.PHONY: logs
logs:
	docker logs -f mariadb-galera || :

client0:
	docker run -it --rm --name mariadb-client --link ${GALERA_NODE_NAME}-0:mariadb-galera \
		mariadb mysql -uroot -p${ROOT_PASSWORD} -D${MARIADB_DATABASE} -h mariadb-galera

client1:
	docker run -it --rm --name mariadb-client --link ${GALERA_NODE_NAME}-1:mariadb-galera \
		mariadb mysql -uroot -p${ROOT_PASSWORD} -D${MARIADB_DATABASE} -h mariadb-galera

client2:
	docker run -it --rm --name mariadb-client --link ${GALERA_NODE_NAME}-2:mariadb-galera \
		mariadb mysql -uroot -p${ROOT_PASSWORD} -D${MARIADB_DATABASE} -h mariadb-galera
