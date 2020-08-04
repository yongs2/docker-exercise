#!/bin/make
#
# docker for gitlab-runner
#

# bind : file name too long (on MacOS)
GITLAB_BASE=${HOME}/temp
BASE=${GITLAB_BASE}/gitlab-runner

NAME=gitlab-runner

.PHONY: daemon
daemon:
	docker run --rm -d \
		--network=host \
		--name ${NAME} \
		--volume ${BASE}/config:/etc/gitlab-runner \
		--volume /var/run/docker.sock:/var/run/docker.sock \
		gitlab/gitlab-runner:latest

run:
	docker run --rm \
		--network=host \
		--name ${NAME} \
		--volume ${BASE}/config:/etc/gitlab-runner \
		--volume /var/run/docker.sock:/var/run/docker.sock \
		gitlab/gitlab-runner:latest

logs:
	docker logs -f ${NAME}

exec:
	docker exec -it ${NAME} /bin/bash

register:
	docker exec -it ${NAME} gitlab-runner register

stop:
	docker stop ${NAME}
	docker rm ${NAME}