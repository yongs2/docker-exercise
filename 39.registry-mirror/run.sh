#!/bin/bash

IMG_NAME=registry
IMG_TAG=2
BASE_DIR=${HOME}/registry

## Example
# vi /etc/docker/daemon.json
#  "registry-mirrors": ["http://127.0.0.1:5000"],

run()
{
  docker run --rm -d \
    -p 5000:5000 \
    -v ${BASE_DIR}/config.yml:/etc/docker/registry/config.yml \
    --name ${IMG_NAME} ${IMG_NAME}:${IMG_TAG}
}

exec()
{
  docker exec -it ${IMG_NAME} /bin/sh
}

logs()
{
  docker logs -f ${IMG_NAME}
}

stop()
{
  docker stop ${IMG_NAME}
}

usage()
{
  echo "${0} [run|exec|logs|stop]"
  docker ps -a | grep ${IMG_NAME}
}

case $1 in
  "run")
    stop
    run
    ;;
  "exec")
    exec
    ;;
  "logs")
    logs
    ;;
  "stop")
    stop
    ;;
  *)
    usage
    exit 1
    ;;
esac
