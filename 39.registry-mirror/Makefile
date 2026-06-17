#!/usr/bin/make -f

#IMG_NAME=registry
#IMG_TAG=2.8.3
#IMG_TAG=3.0.0-rc.2
#IMG_CFG=config.yml
NAME=registry
IMG_NAME=docker.io/yongs2/registry
IMG_TAG=2.8.3
IMG_CFG=config-multi.yml
BASE_DIR=${HOME}/docker/registry
STORAGE_BASE=${BASE_DIR}/storage

.PHONY: run
run:
	docker run -d \
		-p 5000:5000 \
		-v ${BASE_DIR}/${IMG_CFG}:/etc/docker/registry/config.yml \
		-v ${STORAGE_BASE}:/var/lib/registry \
		--name ${NAME} ${IMG_NAME}:${IMG_TAG} || :

.PHONY: exec
exec:
	docker exec -it ${NAME} /bin/sh

.PHONY: stop
stop:
	docker stop ${NAME} || :
	docker rm ${NAME} || :

.PHONY: logs
logs:
	docker logs -f ${NAME} || :

.PHONY: logsget
logsget:
	docker logs -f ${NAME} | grep "GET /v2" || :

.PHONY: repo
repo:
	docker exec -it ${NAME} du -ha -d 3 /var/lib/registry/docker/registry/v2/repositories | grep -v "\/_"

.PHONY: clean
clean:
	docker stop ${NAME} || :
	docker rm ${NAME} || :
	docker rmi ${IMG_NAME}:${IMG_TAG} || :
