#!/usr/bin/make -f

IMG_NAME := localstack
IMG_TAG := 2.0.0
REGISTRY_URL=192.168.5.69:5000
VOLUME=$(PWD)/localstack-volume
WORKDIR=$(PWD)/localstack-exercise

all: chk build

.PHONY: chk
chk:
	IMG_TAG=`curl -s "https://api.github.com/repos/hashicorp/localstack/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/'`
	@printf     "\tlocalstack Version     : ${IMG_TAG}\n"

.PHONY: build
build: chk
	docker build \
		--build-arg LS_VER=${IMG_TAG} \
		-t ${IMG_NAME} -f Dockerfile .

.PHONY: run
run:
	docker run -d -it \
		-p 4566:4566 \
		-p 4510-4559:4510-4559 \
		-v /var/run/docker.sock:/var/run/docker.sock \
		-v ${VOLUME}:/var/lib/localstack \
		-v ${WORKDIR}:/workspace \
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
