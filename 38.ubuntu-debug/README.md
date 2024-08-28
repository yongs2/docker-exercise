# debug for ubuntu:22.04

## kubectl debug 에 필요한 network 관련 패키지를 설치

```sh
# update
apt-get -y update
# install for ip, ping
apt-get -y install iproute2 iputils-ping
```
