# Docker CPU 및 Memory 할당 제어

- [docker CPU, Memory 할당 제어](https://www.joinc.co.kr/w/man/12/docker/limits)
- cpu-priod의 기본 값은 100000(100ms)로, cpu-quota를 이용해서 100ms 동안 어느정도의 cpu 할당할 것인지를 설정

## 1. 성능 측정용 docker image

### 1) sysbench

- [sysbench 는 리눅스 서버의 성능 측정을 진행하는 프로그램](https://extrememanual.net/26680)

### 2) 테스트용 Docker image 생성

- ubuntu:16.04 로 docker build 시 apt-get update 에서 다음과 같은 오류 발생

```sh
...
Reading package lists...
E: Failed to fetch http://security.ubuntu.com/ubuntu/dists/xenial-security/main/binary-amd64/by-hash/SHA256/473c0e20cd20152be87c158a2217bcb2fb03f47907bd2629273513178be3672d  Hash Sum mismatch
E: Some index files failed to download. They have been ignored, or old ones used instead.
...
```

- 구글링 결과 [ubuntu repository cache 문제인 것으로 보임](https://askubuntu.com/questions/872933/how-to-fix-hash-sum-mismatch-error-on-fresh-docker-image-update), 해결책을 적용하여 성공
- sysbench 테스트용 docker image 빌드

```sh
cat << EOF > sysbench.Dockerfile
FROM ubuntu:16.04

RUN rm -rf /etc/apt/sources.list
RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt xenial main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt xenial-updates main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb-src mirror://mirrors.ubuntu.com/mirrors.txt xenial-updates main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt xenial-backports main restricted universe multiverse" >> /etc/apt/sources.list
RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt xenial-security main restricted universe multiverse" >> /etc/apt/sources.list
RUN apt-get update \
    && apt-get -y install sysbench

CMD [ "sysbench", "--test=cpu", "run" ]
EOF
docker build -t sysbench:ubuntu -f sysbench.Dockerfile .
```

## 2. CPU 재한 옵션 비교

- interactive 와 daemon 으로 실행시 차이가 있다는 내용이 있었는데, 시험 결과 차이 없음

### 2-1) CPU 제한 없음 (최신 버전인 경우는 --cpus="1")

```sh
docker run --cpu-period=100000 --cpu-quota=100000 -it sysbench:ubuntu sysbench --test=cpu run

Test execution summary:
    total time:                          14.0625s
```

### 2-2) cpu-quota를 25000 : 1/4 제한 (--cpu="0.25")

```sh
docker run --cpu-period=100000 --cpu-quota=100000 -it sysbench:ubuntu sysbench --test=cpu run

Test execution summary:
    total time:                          55.7555s
```

### 2-3) cpu-period를 50000 : 1/2 제한 (--cpu="0.5")

```sh
docker run --cpu-period=100000 --cpu-quota=100000 -it sysbench:ubuntu sysbench --test=cpu run

Test execution summary:
    total time:                          27.7249s
```

### 2-4) CPU 제한 없음 (최신 버전인 경우는 --cpus="1")

```sh
docker run -d --cpu-period=100000 --cpu-quota=100000 --name test1 sysbench:ubuntu
docker logs -f test1

Test execution summary:
    total time:                          13.5713s
```

### 2-5) cpu-quota를 25000 : 1/4 제한 (--cpu="0.25")

```sh
docker run -d --cpu-period=100000 --cpu-quota=25000 --name test2 sysbench:ubuntu
docker logs -f test2

Test execution summary:
    total time:                          54.1494s
```

### 2-6) cpu-period를 50000 : 1/2 제한 (--cpu="0.5")

```sh
docker run -d --cpu-period=50000 --cpu-quota=25000 --name test3 sysbench:ubuntu
docker logs -f test3

Test execution summary:
    total time:                          27.5620s
```

## 3. 메모리 제한

### 1) 200 M 로 제한

```sh
docker run -m=200m --memory-swap=500m sysbench:ubuntu cat /sys/fs/cgroup/memory/memory.stat  | grep limit
hierarchical_memory_limit 209715200
hierarchical_memsw_limit 524288000
```

### 2) 400 M 제한

```sh
docker run -m=400m --memory-swap=500m sysbench:ubuntu cat /sys/fs/cgroup/memory/memory.stat  | grep limit
hierarchical_memory_limit 419430400
hierarchical_memsw_limit 524288000
```
