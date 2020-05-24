# redis-cluster 구성시 성능 비교

## 1. redis 소스를 빌드하여 cluster 로 구성하여 시험

### 1.1 redis 빌드 환경 구성

- build redis-6.0.3

```sh
docker run -it --rm -v `pwd`/redis-6.0.3:/root/redis-6.0.3 --name centos8-dev centos8-dev /bin/bash
docker exec -it centos8-dev /bin/bash
```

- run redis-servrer on cluster

```sh
cd /root/redis-6.0.3; mkdir bin; make; cp src/redis-erver src/redis-cli /root/redis-6.0.3/bin
export PATH=${PATH}:/root/redis-6.0.3/bin
```

- docker VM : 2 Core, Mem : 2G, 

## 2. redis-standalone 성능 시험

### 2.1 redis 버전별 실행

```sh
docker run -it --rm --name redis5 redis:5.0.9 /bin/bash
docker run -it --rm --name redis6 redis:6.0.0 /bin/bash
docker run -it --rm --name redis6 redis:6.0.3 /bin/bash
```

### 2.2 redis-server 실행

```sh
redis-server --port 7001 --bind 0.0.0.0 &
apt-get update;apt-get install -y procps htop; htop
```

### 2.3 redisbench 실행

- redisbench cluster 테스트

```sh
docker run -it --rm --name golang golang:latest /bin/bash
cd $GOPATH/src; git clone https://github.com/panjiang/redisbench
cd redisbench; 
go run . -a 172.17.0.2:7001 -c 10 -n 10 -d 1000
```

### 2.4 버전별 실행 결과

- redisbench : go run . -a 172.17.0.2:7001 -c 10 -n 10 -d 1000

| redis | condition | Duration |
|---|---|---|
| Redis server v=5.0.9 | Clients Number: 10, Testing Times: 10, Data Size(B): 1000 | TIMES: 100, DUR(s): 0.033, TPS(Hz): 3030 |
| Redis server v=6.0.0 | Clients Number: 10, Testing Times: 10, Data Size(B): 1000 | TIMES: 100, DUR(s): 0.022, TPS(Hz): 4545 |
| Redis server v=6.0.3 | Clients Number: 10, Testing Times: 10, Data Size(B): 1000 | TIMES: 100, DUR(s): 0.037, TPS(Hz): 2702 |

- redisbench : go run . -a 172.17.0.2:7001 -c 1000 -n 10 -d 1000

| redis | condition | Duration |
|---|---|---|
| Redis server v=5.0.9 | Clients Number: 10, Testing Times: 1000, Data Size(B): 1000 | TIMES: 10000, DUR(s): 2.132, TPS(Hz): 4690 |
| Redis server v=6.0.0 | Clients Number: 10, Testing Times: 1000, Data Size(B): 1000 | TIMES: 10000, DUR(s): 2.062, TPS(Hz): 4849 |
| Redis server v=6.0.3 | Clients Number: 10, Testing Times: 1000, Data Size(B): 1000 | TIMES: 10000, DUR(s): 2.073, TPS(Hz): 4823 |

## 3. redis-cluster 성능 시험

### 3.1 redis 버전별 실행 

```sh
docker run -it --rm --name redis5 redis:5.0.9 /bin/bash
docker run -it --rm --name redis6 redis:6.0.0 /bin/bash
docker run -it --rm --name redis6 redis:6.0.3 /bin/bash
```

### 3.2 redis-cluster 구성

- 3 개의 master 로 구성

```sh
redis-server --port 7001 --cluster-enabled yes --cluster-config-file node_7001.conf --cluster-node-timeout 5000 --bind 0.0.0.0

redis-server --port 7002 --cluster-enabled yes --cluster-config-file node_7002.conf --cluster-node-timeout 5000 --bind 0.0.0.0

redis-server --port 7003 --cluster-enabled yes --cluster-config-file node_7003.conf --cluster-node-timeout 5000 --bind 0.0.0.0

redis-cli --cluster create 172.17.0.2:7001 172.17.0.2:7002 172.17.0.2:7003
```

- 3개의 master 와 3 개의 slave 로 구성

```sh
run_redis_cluster.sh start 6

redis-cli --cluster create 172.17.0.2:7001 172.17.0.2:7002 172.17.0.2:7003 172.17.0.2:7004 172.17.0.2:7005 172.17.0.2:7006 --cluster-replicas 1
```

- 3개의 master 와 3 개의 slave 로 구성 - redis:5.0.9 성능 시험 
    - 조건 : -c 10 -n 10 -d 1000

    ```sh
    go run . -cluster=true -a 172.17.0.2:7001,172.17.0.2:7002,172.17.0.2:7003,172.17.0.2:7004,172.17.0.2:7005,172.17.0.2:7006 -c 10 -n 10 -d 1000

    2020/05/24 09:13:56 # BENCHMARK CLUSTER (172.17.0.2:7001,172.17.0.2:7002,172.17.0.2:7003,172.17.0.2:7004,172.17.0.2:7005,172.17.0.2:7006, db:0)
    2020/05/24 09:13:56 * Clients Number: 10, Testing Times: 10, Data Size(B): 1000
    2020/05/24 09:13:56 * Total Times: 100, Total Size(B): 100000
    2020/05/24 09:13:56 # BENCHMARK DONE
    2020/05/24 09:13:56 * TIMES: 100, DUR(s): 0.068, TPS(Hz): 1470
    ```
    - 조건 : -c 10 -n 1000 -d 1000

    ```sh
    go run . -cluster=true -a 172.17.0.2:7001,172.17.0.2:7002,172.17.0.2:7003,172.17.0.2:7004,172.17.0.2:7005,172.17.0.2:7006 -c 10 -n 1000 -d 1000

    2020/05/24 09:13:31 # BENCHMARK CLUSTER (172.17.0.2:7001,172.17.0.2:7002,172.17.0.2:7003,172.17.0.2:7004,172.17.0.2:7005,172.17.0.2:7006, db:0)
    2020/05/24 09:13:31 * Clients Number: 10, Testing Times: 1000, Data Size(B): 1000
    2020/05/24 09:13:31 * Total Times: 10000, Total Size(B): 10000000
    2020/05/24 09:13:34 # BENCHMARK DONE
    2020/05/24 09:13:34 * TIMES: 10000, DUR(s): 2.898, TPS(Hz): 3450
    ```

### 2.3 redisbench 실행

- redisbench cluster 테스트

```sh
docker run -it --rm --name golang golang:latest /bin/bash
cd $GOPATH/src; git clone https://github.com/panjiang/redisbench
cd redisbench; 
go run . -cluster=true -a 172.17.0.2:7001,172.17.0.2:7002,172.17.0.2:7003 -c 10 -n 10 -d 1000
```

### 3.4 버전별 실행 결과

- 3개의 master 구성

| redis | condition | Duration |
|---|---|---|
| Redis server v=5.0.9 | Clients Number: 10, Testing Times: 10, Data Size(B): 1000 | TIMES: 100, DUR(s): 0.059, TPS(Hz): 1694 |
| Redis server v=6.0.0 | Clients Number: 10, Testing Times: 10, Data Size(B): 1000 | TIMES: 100, DUR(s): 1.213, TPS(Hz): 82 |
| Redis server v=6.0.3 | Clients Number: 10, Testing Times: 10, Data Size(B): 1000 | TIMES: 100, DUR(s): 1.308, TPS(Hz): 76 |

- 3개의 master 와 3 개의 slave 로 구성

| redis | condition | Duration |
|---|---|---|
| Redis server v=5.0.9 | Clients Number: 10, Testing Times: 10, Data Size(B): 1000 | TIMES: 100, DUR(s): 0.068, TPS(Hz): 1470 |
| Redis server v=6.0.0 | Clients Number: 10, Testing Times: 10, Data Size(B): 1000 | TIMES: 100, DUR(s): 2.490, TPS(Hz): 40 |
| Redis server v=6.0.3 | Clients Number: 10, Testing Times: 10, Data Size(B): 1000 | TIMES: 100, DUR(s): 2.696, TPS(Hz): 37 |

### 3.5 redis 버전별 소스

- https://github.com/antirez/redis/archive/6.0.3.tar.gz , 2020/05/16
- https://github.com/antirez/redis/archive/6.0.0.tar.gz , 2020/04/30
- https://github.com/antirez/redis/archive/5.0.9.tar.gz , 2020/04/17 

### 참고 자료

- [Redis – cluster](https://daddyprogrammer.org/post/1601/redis-cluster/)
- [Redis Release Notes 6.0.1](http://redisgate.kr/redis/introduction/redis_release6.php)
