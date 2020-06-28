# redis-node

## 1. redis-node 구성

### 1.1 redis-node1

- run docker container for node1

```sh
make node1
```

- run redis-server and sentinel

```sh
/data/redis-node1-run.sh
```

### 1.2 redis-node2

- run docker container for node2

```sh
make node2
```

- run redis-server and sentinel

```sh
/data/redis-node2-run.sh
```

### 1.3 redis-node3

- run docker container for node3

```sh
make node3
```

- run redis-server and sentinel

```sh
/data/redis-node3-run.sh
```

### 1.5 Load balancing

- [HA Proxy](http://www.haproxy.org/)
- [haproxy-2.1.git](http://git.haproxy.org/git/haproxy-2.1.git/)
- [haproxy](https://github.com/haproxy/haproxy)
- [Redis (7) HAProxy (load balancing)](https://velog.io/@labyu/Redis-7)
- [haproxy & keepalived 로 프록시 구축하기](https://www.nakjunizm.com/2020/02/20/haproxy/)

- docker run

```sh
docker pull haproxy:2.1.7-alpine
```
