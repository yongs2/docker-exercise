#!/bin/sh

REGISTRY=192.168.0.210:5000

del_repository() {
  REPOSITORY=$1
  TAG=$2

  #echo "curl -v --silent -H 'Accept: application/vnd.docker.distribution.manifest.v2+json' -X GET http://${REGISTRY}/v2/${REPOSITORY}/manifests/${TAG} 2>&1 | grep Docker-Content-Digest | awk '{print ($3)}'"
  DIGEST=`curl -v --silent -H 'Accept: application/vnd.docker.distribution.manifest.v2+json' -X GET http://${REGISTRY}/v2/${REPOSITORY}/manifests/${TAG} 2>&1 | grep Docker-Content-Digest | awk '{print ($3)}'`

  echo ${DIGEST}

  URL=http://${REGISTRY}/v2/${REPOSITORY}/manifests/${DIGEST}
  URL=${URL%$'\r'}
  #echo "curl -v --silent -H 'Accept: application/vnd.docker.distribution.manifest.v2+json' -X DELETE ${URL}"
  curl -v --silent -H 'Accept: application/vnd.docker.distribution.manifest.v2+json' -X DELETE ${URL}
}

garbage-collect() {
  docker exec -it docker-registry registry garbage-collect /etc/docker/registry/config.yml
}

del_repository ${1} ${2}
