#!/usr/bin/make -f

IMG_NAME ?= terraform
IMG_TAG ?= 1.12
CAPA_VER ?= 2.7.1
REGISTRY_URL ?= 192.168.5.69:5000

all: chk build

.PHONY: chk
chk:
	IMG_TAG=`curl -s "https://api.github.com/repos/hashicorp/terraform/releases/latest" | grep '"tag_name":' | sed -E 's/.*"v([^"]+)".*/\1/'`
	@printf     "\tTerraform Version     : ${IMG_TAG}\n"

.PHONY: build
build: chk
	docker build \
		--build-arg TF_VER=$(IMG_TAG) \
		--build-arg CAPA_VER=$(CAPA_VER) \
		-t $(IMG_NAME) -f Dockerfile .

.PHONY: run
run:
	docker run -it \
		--network=host \
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
	@printf     "\tImage                 : ${IMG_NAME}:${IMG_TAG}\n"
