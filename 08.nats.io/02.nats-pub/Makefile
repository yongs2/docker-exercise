#MAKEFILE

REGISTRY_URL := docker.io/yongs2
IMG_NAME := nats-pub
IMG_TAG := 1.0.0

.PHONY: build
build:
	docker build -t ${IMG_NAME} -f Dockerfile .

.PHONY: run
run:
	docker run \
		-e NATS_URL=nats \
		-e SUBJECT=foo \
		-e MESSAGE="NATS MESSAGE 1" \
		--link nats:nats \
		--rm --name ${IMG_NAME} ${IMG_NAME} || :

.PHONY: runit
runit:
	docker run -it \
		--link nats:nats \
		--entrypoint "/bin/bash" \
		--rm --name ${IMG_NAME} ${IMG_NAME} || :

.PHONY: push
push:
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
	docker logs -f ${IMG_NAME} || :
