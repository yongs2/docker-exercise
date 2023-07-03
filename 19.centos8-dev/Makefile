# Makefile

REGISTRY_URL := docker.io/yongs2
IMG_NAME := centos8-dev
IMG_TAG := 1.0.0

.PHONY: build
build:
	docker build -t ${IMG_NAME} -f Dockerfile .

.PHONY: run
run:
	docker run -it \
		--rm --name ${IMG_NAME} \
		-v `pwd`/project:/root/project \
		-e PRJ_HOME=/root/project \
		${IMG_NAME} || :

.PHONY: upload
upload:
	docker tag ${IMG_NAME} ${REGISTRY_URL}/${IMG_NAME}:${IMG_TAG}
	docker push ${REGISTRY_URL}/${IMG_NAME}:${IMG_TAG}

.PHONY: exec
exec:
	docker exec -it ${IMG_NAME} /bin/bash

.PHONY: stop
stop:
	docker stop ${IMG_NAME} || :

.PHONY: logs
logs:
	docker logs -f ${IMG_NAME} ||
