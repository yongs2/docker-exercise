#!/bin/bash

nats-pub -s ${NATS_URL} ${SUBJECT} "${MESSAGE}"
