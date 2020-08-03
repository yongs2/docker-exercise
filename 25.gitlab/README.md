# gitlab server

## 1. gitlab

### 1.1 run gitlab

```sh
GITLAB_HOST=`curl 'https://api.ipify.org'`:9080
mkdir gitlab
make -f gitlab.mk run
make -f gitlab.mk logs
```

### 1.2 connect gitlab

```sh
/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --kiosk http://localhost:9080
```

## 2. gitlab-runner

### 2.1 run gitlab-runner

```sh
mkdir gitlab-runner
make -f gitlab-runner.mk run
```

### 2.2 register

```sh
make -f gitlab-runner.mk exec

gitlab-runner register
```
