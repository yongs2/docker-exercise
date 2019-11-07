# redmine plugin 설치된 docker 이미지

- [Redmine-docker컨테이너와 플러그인..](https://brunch.co.kr/@cheuora/45) 을 참조
- redmine 을 프로젝트 및 테스트 관리 도구로 사용하는데, 관리하기 쉽게 하기 위해서 docker 를 이용한다는 내용임
- 그런데, bitnami 의 redmine docker 이미지에는 plugin이 없는 데, 추가로 필요한 redmine plugin 설치 때문에 컨테이너를 기동 후에 추가 작업을 진행함
- bitnami 의 docker 구성에 대해 살펴보니, docker-compose 로 구성되어 있어서, 이를 활용하여 plugin 을 추가 설치한 이미지를 관리하는 방안을 정리
- [bitnami 의 docker-compose 구성](https://github.com/bitnami/bitnami-docker-redmine)
