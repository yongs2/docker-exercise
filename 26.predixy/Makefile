# Makefile

IMG_NAME := docker-predixy
IMG_TAG := 1.0.0

.PHONY: build
build:
	docker build -t ${IMG_NAME} -f Dockerfile .

.PHONY: run
run:
	docker run -it \
		--rm --name ${IMG_NAME} \
		-v `pwd`/conf:/etc/predixy/conf \
		${IMG_NAME} || :

.PHONY: exec
exec:
	docker exec -it ${IMG_NAME} /bin/bash

.PHONY: stop
stop:
	docker stop ${IMG_NAME} || :

.PHONY: logs
logs:
	docker logs -f ${IMG_NAME} ||
