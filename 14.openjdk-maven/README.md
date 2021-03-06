# jmeter plugin 빌드 이미지

- [jmeter-http2-plugin](https://github.com/Blazemeter/jmeter-http2-plugin) 를 빌드하기 위한 이미지

## 구성 요소

- openjdk 8u232 를 기반으로, maven 3.6.3 을 설치하여, 빌드 환경을 구성

## 사용 예제

- jmeter-http2-plugin 을 빌드하는 절차

### 1) docker 기동

```sh
docker run -it --rm -v C:\src:/root/src mvn-openjdk-8u232 /bin/bash
```

### 2) 소스 clone 후 빌드
```sh
cd /root/src;
git clone https://github.com/Blazemeter/jmeter-http2-plugin
cd jmeter-http2-plugin;
mvn install
ls -altr target/*.jar
```

### 3) Fork 한 repository 최신으로 동기화하기

```sh
git clone https://github.com/yongs2/jmeter-http2-plugin.git
cd jmeter-http2-plugin

git remote -v
origin	https://github.com/yongs2/jmeter-http2-plugin.git (fetch)
origin	https://github.com/yongs2/jmeter-http2-plugin.git (push)

git remote add upstream https://github.com/Blazemeter/jmeter-http2-plugin
git remote -v
origin	https://github.com/yongs2/jmeter-http2-plugin.git (fetch)
origin	https://github.com/yongs2/jmeter-http2-plugin.git (push)
upstream	https://github.com/Blazemeter/jmeter-http2-plugin (fetch)
upstream	https://github.com/Blazemeter/jmeter-http2-plugin (push)

git fetch upstream
git merge upstream/master
git push origin master

git remote rm upstream
remotes/origin/cleanup-http2-stream-handler
git branch --delete cleanup-http2-stream-handler
git push origin :cleanup-http2-stream-handler
```
