#!/bin/sh

docker run -u root --rm -p 8080:8080 --name jenkins \
    -v ${HOME}/workspace/jenkins_home:/var/jenkins_home \
    -v /var/run/docker.sock:/var/run/docker.sock \
    subicura/jenkins:2
