# centos8 c 빌드용 docker image 생성

## 1. docker images 생성

```sh
make build
```

### 2. c 빌드

- docker 실행

```sh
make run
```

- make

```sh
cd /root/project/src
make; make install
```

- run app

```sh
cd /root/proeject/bin
./test
```
