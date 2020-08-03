#!/bin/make
#
# docker for gitlab-runner
#

GITLAB_BASE=`pwd`
BASE=${GITLAB_BASE}/gitlab-runner

NAME=gitlab-runner

.PHONY: runner
runner:
	docker run --rm -d \
		--network=host \
		--name ${NAME} \
		--volume ${BASE}/config:/etc/gitlab-runner \
		--volume /var/run/docker.sock:/var/run/docker.sock \
		gitlab/gitlab-runner:latest

logs:
	docker logs -f ${NAME}

exec:
	docker exec -it ${NAME} /bin/bash

stop:
	docker stop ${NAME}
	docker rm ${NAME}