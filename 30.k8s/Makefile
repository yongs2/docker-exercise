#MAKEFILE

IMG_NAME := k8s
IMG_TAG := latest
ALPINE_VERSION := 3.14.2
YQ_VERSION := 4.14.1

.PHONY: build
build:
	docker build \
		--network host \
		--build-arg ALPINE_VERSION=${ALPINE_VERSION} \
		--build-arg YQ_VERSION=${YQ_VERSION} \
		-t ${IMG_NAME} -f Dockerfile .

.PHONY: run
run:
	docker run -it \
		--rm --name ${IMG_NAME} ${IMG_NAME} || :

.PHONY: push
push:
	docker tag ${IMG_NAME} ${IMG_NAME}:${IMG_TAG}
	docker push ${IMG_NAME}:${IMG_TAG}

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
	docker rmi ${IMG_NAME} ${IMG_NAME}:${IMG_TAG} ${IMG_NAME}:${IMG_TAG} || :
