# redis replication

- [레디스 클러스터, Read from Slave](https://brunch.co.kr/@springboot/218)

## maste-slave 구성

### 0. redis 간의 name 으로 연결이 가능하도록 네트워크 생성

```sh
make network
docker network ls
```

### 1. redis-master 구성

- redis-master 기동

```sh
make master
```

- redis-slave1 기동

```sh
make slave1
```

### 2. sentinel 구성

- sentinel 이 기동되면, config 파일에 추가로 내용을 변경하므로, 각각의 config 파일을 설정해야 함

```sh
make sentinel1
make sentinel2
make sentinel3
```

### 3. failover 테스트

- redis-master 와 연결하는 redis-cli 실행

```sh
make client0
```

- redis-slave1 과 연결하는 redis-cli 실행

```sh
make client1
```

- redis-master 를 강제 종료하면, sentinel1,2,3 에서 감지를 하여, redis-slave1 을 master로 승격

### 4. docker-compose 로 failover 테스트

- 사전 준비, sentinel 설정 파일을 개별로 복사

```sh
cd /Users/yongs2/workspace/docker-exercise/17.redis-sentinel
/bin/cp ./sentinel/sentinel.conf ./sentinel/sentinel1.conf
/bin/cp ./sentinel/sentinel.conf ./sentinel/sentinel2.conf
/bin/cp ./sentinel/sentinel.conf ./sentinel/sentinel3.conf
```

- 기동

```sh
docker-compose up
```

- redis-master container 를 강제 종료

```sh
CONTANINER_MASTER=`docker ps --filter name=master -q`
docker exec -it ${CONTANINER_MASTER} redis-cli debug segfault
```

- redis-slave1 container 에 접속하여 redis-cli 로 keys/get/set 명령으로 정상 동작 확인

```sh
CONTANINER_SLAVE1=`docker ps --filter name=slave -q`
docker exec -it ${CONTANINER_SLAVE1} redis-cli
```

- redis-master container 를 재기동하여 slave 로 동작하는 지 확인

```sh
CONTANINER_MASTER=`docker ps -a --filter name=master -q`
docker restart ${CONTANINER_MASTER}
docker exec -it ${CONTANINER_MASTER} redis-cli
```
