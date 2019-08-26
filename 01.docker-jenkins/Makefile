#MAKEFILE

REGISTRY_URL := docker.io/yongs2
IMG_NAME := docker-jenkins
IMG_TAG := 1.0.0
PREV_JENKINS_HOME := ${HOME}/workspace/jenkins_home

.PHONY: build
build:
	rm -Rf .temp/
	mkdir -p .temp/
	/bin/cp -f ${PREV_JENKINS_HOME}/config.xml .temp/config.xml
	/bin/cp -Rf ${PREV_JENKINS_HOME}/jobs .temp/jobs
	/bin/cp -Rf ${PREV_JENKINS_HOME}/secrets .temp/secrets
	/bin/cp -Rf ${PREV_JENKINS_HOME}/users .temp/users
	/bin/cp -f ${PREV_JENKINS_HOME}/plugins.txt .temp/plugins.txt
	docker build -t ${IMG_NAME} -f Dockerfile .

.PHONY: run
run:
	docker run -d \
		-p 8080:8080 \
		-p 50000:50000 \
		--rm --name ${IMG_NAME} ${IMG_NAME} || :

.PHONY: push
push:
	docker tag ${IMG_NAME}:${IMG_TAG} ${REGISTRY_URL}/${IMG_NAME}:${IMG_TAG}
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
