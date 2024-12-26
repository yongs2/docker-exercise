#!/usr/bin/make -f

IMG_NAME=registry
IMG_TAG=2
BASE_DIR=${HOME}/docker/registry

.PHONY: run
run:
	docker run -d \
		-p 5000:5000 \
		-v ${BASE_DIR}/config.yml:/etc/docker/registry/config.yml \
		--name ${IMG_NAME} ${IMG_NAME}:${IMG_TAG} || :

.PHONY: exec
exec:
	docker exec -it ${IMG_NAME} /bin/sh

.PHONY: stop
stop:
	docker stop ${IMG_NAME} || :

.PHONY: logs
logs:
	docker logs -f ${IMG_NAME} || :

.PHONY: repo
repo:
	docker exec -it ${IMG_NAME} du -ha -d 2 /var/lib/registry/docker/registry/v2/repositories

.PHONY: clean
clean:
	docker stop ${IMG_NAME} || :
	docker rm ${IMG_NAME} || :
