#!/bin/bash

KAFKA_VERSION=2.12-2.3.0

DOCKER_HOST_IP=$(ip -4 addr show docker0 | grep -Po 'inet \K[\d.]+')
ZK_HOST=$(docker exec zookeeper ip -4 addr show eth0 | grep -Po 'inet \K[\d.]+')
ZK_PORT=2181
ZK_NETWORK=$(docker network ls | grep test | awk '{print $2}')

docker run --rm \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -e HOST_IP=${DOCKER_HOST_IP} \
    -e ZK=${ZK_HOST}:${ZK_PORT} \
    --link zookeeper:zookeeper \
    --network ${ZK_NETWORK} \
    -i -t wurstmeister/kafka:${KAFKA_VERSION} /bin/bash
