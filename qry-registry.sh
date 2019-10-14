#!/bin/sh

REGISTRY=192.168.0.210:5000

REPOSITORIES=`curl -s -X GET http://${REGISTRY}/v2/_catalog | jq -c -r '.repositories[]'`

for REPOSITRY in ${REPOSITORIES}
do
        curl -s -X GET http://${REGISTRY}/v2/${REPOSITRY}/tags/list | jq
done
