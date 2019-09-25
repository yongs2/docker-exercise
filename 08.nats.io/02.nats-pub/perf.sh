#!/bin/bash

i=0
while [ $i -le ${1} ]
do
  nats-pub -s nats foo "Hello NATS again ${i}"
  ((i++))
done
