#!/bin/bash

MAX=3
BASE_PORT=7000

redis_cluster_run()
{
    MAX=$1
    if [ "X$MAX" == "X" ] ; then
        echo "Redis Cluster requires at least 3 master nodes."
        MAX=3
    fi

    for ind in `seq 1 ${MAX}`; do \
        let port=${BASE_PORT}+${ind}
        echo $port
        redis-server --port ${port} --cluster-enabled yes --cluster-config-file node_${port}.conf --cluster-node-timeout 5000 --bind 0.0.0.0 &
    done
}

redis_cluster_create()
{
    MAX=$1
    if [ "X$MAX" == "X" ] ; then
        echo "Redis Cluster requires at least 3 master nodes."
        MAX=3
    fi

    IP=`hostname -i`

    for ind in `seq 1 ${MAX}`; do
        let PORT=${BASE_PORT}+${ind}
        IPS="${IPS} ${IP}:${PORT}"
    done

    echo "IPS=$IPS"
    if [ "X$IPS" != "X" ] ; then
        echo yes | redis-cli --cluster create ${IPS}
    else
        echo "Not Cluster"
    fi
}

case $1 in
    start)
        redis_cluster_run $2
        ;;
    create)
        redis_cluster_create $2
        ;;
    all)
        redis_cluster_run $2
        redis_cluster_create $2
        ;;
    *)
        echo "$0 start|create|all" ;;
esac
