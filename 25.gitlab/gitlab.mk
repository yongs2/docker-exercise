#!/bin/make
#
# docker for gitlab
#

GITLAB_BASE=${HOME}/temp
BASE=${GITLAB_BASE}/gitlab

CI_HOST=gitlab-ci.com
CI_IP=`hostname`

NAME=gitlab

.PHONY: daemon
daemon:
	docker run --rm -d \
	    --hostname ${GITLAB_HOST} \
	    -p 9443:443 \
	    -p 9080:9080 \
	    -p 9022:22 \
	    -p 5005:5005 \
	    -e GITLAB_OMNIBUS_CONFIG="external_url 'http://$CI_HOST:9080/'; gitlab_rails['gitlab_shell_ssh_port'] = 22 ; nginx['listen_port'] = 9080; registry_external_url 'https://$CI_HOST:5005' " \
	    --name ${NAME} \
	    --volume ${BASE}/config:/etc/gitlab \
	    --volume ${BASE}/logs:/var/log/gitlab \
	    --volume ${BASE}/data:/var/opt/gitlab \
	    gitlab/gitlab-ce:latest

run:
	docker run --rm \
	    --hostname ${GITLAB_HOST} \
	    -p 9443:443 \
	    -p 9080:9080 \
	    -e GITLAB_OMNIBUS_CONFIG="external_url 'http://$CI_HOST:9080/'; gitlab_rails['gitlab_shell_ssh_port'] = 22 ; nginx['listen_port'] = 9080; registry_external_url 'https://$CI_HOST:5005' " \
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
