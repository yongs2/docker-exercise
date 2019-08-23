# [docker 에서 jenkins를 이용하여 지속적 통합 및 배포](https://github.com/subicura/docker-jenkins-workshop)

## 1. docker 를 이용하여 배포하는 절차

### 1) 배포 과정

- 소스 저장소에서 최신 소스를 저장
- 전체 소스를 다운로드
- 테스트
- Docker 이미지 만들기
- DOcker 이미지 저장하기
- 어플리케이션 업데이트

### 2) jenkins 실행

```sh
docker run -u root --rm -p 8080:8080 --name jenkins \
 -v ${HOME}/workspace/jenkins_home:/var/jenkins_home \
 -v /var/run/docker.sock:/var/run/docker.sock \
 subicura/jenkins:2
```

- 접속 : http://192.168.0.6:8080
- Create First User
  - admin / 1234 / admin / yongs2yj@gmail.com

### 3) pipeline

- pipeline 
- check : Do not allow concurrent builds
- check : github project
  - https://github.com/subicura/docker-jenkins-workshop
- 구성 > pipelin > pipeline script
  - groovy 에서 여러 줄을 입력하는 경우에는 '''로 쌓야 함.
  - withCredentials 에서 오류가 발생하면, 최신 버전(2.176.2) 업그레이드, plugin 업그레이드를 진행
  - BUILD_NUMBER 등 [환경 변수](https://wiki.jenkins.io/display/JENKINS/Building+a+software+project) 정보 참조

```Jenkinsfile
node {
    git poll: true, url: 'https://github.com/subicura/docker-jenkins-workshop.git'
    
    withCredentials([[$class: 'UsernamePasswordMultiBinding',
        credentialsId: 'dockerhub',
        usernameVariable: 'DOCKER_USER_ID', 
        passwordVariable: 'DOCKER_USER_PASSWORD']]) {
        stage('Pull') {
            git 'https://github.com/subicura/docker-jenkins-workshop.git'
        }
        stage('Unit Test') {
        }
        stage('Build') {
            sh(script: '''docker build --force-rm=true \
                -t ${DOCKER_USER_ID}/ruby-app:latest .''')
        }
        stage('Tag') {
            sh(script: 'docker tag ${DOCKER_USER_ID}/ruby-app ${DOCKER_USER_ID}/ruby-app:${BUILD_NUMBER}')
        }
        stage('Push') {
            sh(script: 'docker login -u ${DOCKER_USER_ID} -p ${DOCKER_USER_PASSWORD}')
            sh(script: 'docker push ${DOCKER_USER_ID}/ruby-app:${BUILD_NUMBER}')
            sh(script: 'docker push ${DOCKER_USER_ID}/ruby-app:latest')
        }
        stage('Deploy') {
            try {
                sh(script: 'docker stop ruby-app')
                sh(script: 'docker rm ruby-app')
            }
            catch(e) {
                echo "No ruby-app container exist"
            }
            sh(script: '''docker run -d -p 10000:4567 --name=ruby-app \
                ${DOCKER_USER_ID}/ruby-app:${BUILD_NUMBER}''')
        }
    }
}
```

- Credentials > Add credential > username with password
  ID : dockerhub
  Description : hub.docker.com account

- Build Triggers
  - Poll SCM
    - schedule : * * * * * (1분마다)
  - node 추가
    - git poll: true, url: 'https://github.com/subicura/docker-jenkins-workshop.git'

- Plugin 중 blue ocean 을 설치
