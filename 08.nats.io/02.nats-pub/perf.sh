#!/bin/bash

i=0
while [ $i -le ${1} ]
do
  nats-pub -s ${NATS_URL} ${SUBJECT} "Hello NATS again ${i}"
  ((i++))
done
