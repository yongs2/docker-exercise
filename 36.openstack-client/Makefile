#!/usr/bin/make -f

IMG_NAME := openstack-client
IMG_TAG := 3.12-bookworm
REGISTRY_URL=192.168.5.69:5000

all: build

.PHONY: build
build:
	docker build \
		--build-arg PYTHON_VERSION=${IMG_TAG} \
		-t ${IMG_NAME} -f Dockerfile .

.PHONY: run
run:
	docker run -d -it \
		--rm --name ${IMG_NAME} ${IMG_NAME} || :

.PHONY: push
push:
	docker tag ${IMG_NAME} ${REGISTRY_URL}/${IMG_NAME}:${IMG_TAG}
	docker tag ${IMG_NAME} ${REGISTRY_URL}/${IMG_NAME}:latest
	docker push ${REGISTRY_URL}/${IMG_NAME}:${IMG_TAG}
	docker push ${REGISTRY_URL}/${IMG_NAME}:latest

.PHONY: exec
exec:
	docker exec -it ${IMG_NAME} /bin/bash

.PHONY: stop
stop:
	docker stop ${IMG_NAME} || :

.PHONY: logs
logs:
	docker logs -f ${IMG_NAME} || :

.PHONY: clean
clean:
	docker stop ${IMG_NAME} || :
	docker rm ${IMG_NAME} || :
	docker rmi ${IMG_NAME} ${IMG_NAME}:${IMG_TAG} ${REGISTRY_URL}/${IMG_NAME}:${IMG_TAG} || :

regInfo:
	@printf     "\tDocker Registry       : ${REGISTRY_URL}\n"
