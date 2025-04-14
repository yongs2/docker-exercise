#!/usr/bin/make -f

PYTHON_VERSION := 3.11
IMG_NAME := operator-pydev
IMG_TAG := ${PYTHON_VERSION}
REGISTRY_URL := $${MY_REGISTRY_URL:=docker.io/yongs2}

all: clean build

.PHONY: build
build: ## build docker image
	docker build \
		--network host \
		--build-arg REGISTRY_URL=${REGISTRY_URL} \
		--build-arg PYTHON_VERSION=${PYTHON_VERSION} \
		-t ${IMG_NAME} -f Dockerfile .

.PHONY: run
run: ## run container
	docker run -it \
		--network=host \
		-e GO111MODULE=on \
		--rm --name ${IMG_NAME} ${IMG_NAME} || :

.PHONY: push
push: ## run registry
	docker tag ${IMG_NAME} ${REGISTRY_URL}/${IMG_NAME}:${IMG_TAG}
	docker tag ${IMG_NAME} ${REGISTRY_URL}/${IMG_NAME}:latest
	docker push ${REGISTRY_URL}/${IMG_NAME}:${IMG_TAG}
	docker push ${REGISTRY_URL}/${IMG_NAME}:latest

.PHONY: exec
exec: ## exec container
	docker exec -it ${IMG_NAME} /bin/bash

.PHONY: stop
stop: ## stop container
	docker stop ${IMG_NAME} || :

.PHONY: logs
logs: ## log container
	docker logs -f ${IMG_NAME} || :

.PHONY: clean
clean: ## stop container and remove image
	docker stop ${IMG_NAME} || :
	docker rm ${IMG_NAME} || :
	docker rmi ${IMG_NAME} ${IMG_NAME}:${IMG_TAG} ${REGISTRY_URL}/${IMG_NAME}:${IMG_TAG} || :

regInfo:
	@printf     "\tDocker Registry       : ${REGISTRY_URL}\n"

help: ## Display this help screen
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
