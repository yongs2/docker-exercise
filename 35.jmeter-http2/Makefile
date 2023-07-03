#!/usr/bin/make -f

IMG_NAME := jmeter-http2
IMG_TAG := 1.0.0
JDK_VERSION := 11 
JMETER_VERSION := 5.5
HTTP2_VERSION := 2.0.2
TIME_ZONE := "Asia/Seoul"
REGISTRY_URL := $${MY_REGISTRY_URL:=docker.io/yongs2}

.PHONY: build
build:
	docker build --no-cache \
		--network host \
		--build-arg JDK_VERSION=${JDK_VERSION} \
		--build-arg JMETER_VERSION=${JMETER_VERSION} \
		--build-arg HTTP2_VERSION=${HTTP2_VERSION} \
		--build-arg TZ=${TIME_ZONE} \
		-t ${IMG_NAME} -f Dockerfile .

.PHONY: run
run:
	docker run -it \
		--network=host \
		-e JVM_ARGS="-Xms2048m -Xmx2048m" \
		-v ${PWD}:/work \
		-w /work \
		--rm --name ${IMG_NAME} ${IMG_NAME} \
		-n \
		-p /work/reportgenerator.properties \
		-L WARN \
		-t perf_test.jmx \
		-l perf_result.csv \
		-e -o result_dir || :

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
