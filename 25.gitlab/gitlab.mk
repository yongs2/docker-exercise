#!/bin/make
#
# docker for gitlab
#

GITLAB_BASE=`pwd`
BASE=${GITLAB_BASE}/gitlab

NAME=gitlab

.PHONY: run
run:
	docker run --rm -d \
	    --hostname ${GITLAB_HOST} \
	    -p 9443:443 \
	    -p 9080:9080 \
	    -p 9022:22 \
	    --name ${NAME} \
	    --volume ${BASE}/config:/etc/gitlab \
	    --volume ${BASE}/logs:/var/log/gitlab \
	    --volume ${BASE}/data:/var/opt/gitlab \
	    gitlab/gitlab-ce:latest

logs:
	docker logs -f ${NAME}

exec:
	docker exec -it ${NAME} /bin/bash

stop:
	docker stop ${NAME}
	docker rm ${NAME}