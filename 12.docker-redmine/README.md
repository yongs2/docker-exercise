# redmine plugin 설치된 docker 이미지

## 개요

- [Redmine-docker컨테이너와 플러그인..](https://brunch.co.kr/@cheuora/45) 을 참조
- redmine 을 프로젝트 및 테스트 관리 도구로 사용하는데, 관리하기 쉽게 하기 위해서 docker 를 이용한다는 내용임
- 그런데, bitnami 의 redmine docker 이미지에는 plugin이 없는 데, 추가로 필요한 redmine plugin 설치 때문에 컨테이너를 기동 후에 추가 작업을 진행함
- bitnami 의 docker 구성에 대해 살펴보니, docker-compose 로 구성되어 있어서, 이를 활용하여 plugin 을 추가 설치한 이미지를 관리하는 방안을 정리
- [bitnami 의 docker-compose 구성](https://github.com/bitnami/bitnami-docker-redmine) 을 참조

## 수정 사항

- docker-compose.yml 에서 bitnami/redmine:4 이미지 참조를 build 하도록 변경 (참조: [도커 컴포즈를 활용하여 완벽한 개발 환경 구성하기](https://www.44bits.io/ko/post/almost-perfect-development-environment-with-docker-and-docker-compose))
- redmine_data 폴더를 HOST의 docker-compose 가 실행되는 하위 디렉토리와 매핑하도록 수정

## 실행 방법

- HOST 에서 docker-compose 및 redmine_data 가 기록될 상위 디렉토리 설정
- 하위 디렉토리에 redmine_data 생성
- docker-compose up 실행하면 mariadb 는 다운로드 받을 것이며, redmine 은 build 를 진행함
- docker images 는 local 에 생성된다.

```sh
$ docker images | grep bitnami
bitnami-docker-redmine_redmine    latest              fd48b858d20e        15 minutes ago      1.59GB
bitnami/mariadb                   10.3                f20700e39512        29 hours ago        289MB
bitnami/redmine                   4                   df4695dc35f3        8 days ago          1.05GB
```

- 기동이 완료되면 redmine_data/redmine/plugins 디렉토리가 생성되었는 지 확인
- 필요한 plugin 패키지를 다운로드 받아서 unzip 으로 압축해제 한다.
- docker-compose down 으로 중지 후 docker-compose up 으로 재기동하면 plugin 이 적용된 redmine 을 확인할 수 있음
