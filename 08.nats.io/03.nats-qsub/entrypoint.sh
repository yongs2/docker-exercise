#!/bin/bash

nats-qsub -s ${NATS_URL} ${SUBJECT} ${QUEUE}
