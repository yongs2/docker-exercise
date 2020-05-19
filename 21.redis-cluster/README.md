# Redis-cluster 구성

## 0. docker network

```sh
make network
docker networks ls
```

## 1. run redis-cluster

```sh
make cluster1
make cluster2
make cluster3
docker ps
```

## 2. create cluster

```sh
make create_cluster
```
