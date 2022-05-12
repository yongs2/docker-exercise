# rockylinux 보안 패치

## docker image 보안 점검

- [Trivy](https://github.com/aquasecurity/trivy) 를 이용하여 docker.io/rockylinux 의 이미지를 점검

```sh
docker run --rm -v "/var/run/docker.sock:/var/run/docker.sock" -v "/tmp":/root/.cache aquasec/trivy:0.25.4 image rockylinux:latest
```

- 점검 결과에 따라 추가로 패키지를 업데이트 진행
