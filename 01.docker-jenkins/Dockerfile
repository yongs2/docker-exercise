# jenkins/jenkins:lts
FROM docker.io/jenkins/jenkins:2.176.2

USER root
ARG HOST_HOME

ENV PREV_JENKINS_HOME=${HOST_HOME}/workspace/jenkins_home

# docker 설치
RUN curl -fsSL https://get.docker.com -o get-docker.sh \
    && chmod +x get-docker.sh \
    && ./get-docker.sh \
    && usermod -aG docker jenkins

# 기존 jenkins 설정을 복사
ADD .temp/config.xml /usr/share/jenkins/ref/config.xml
ADD executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy
ADD .temp/jobs /usr/share/jenkins/ref/jobs
ADD .temp/secrets /usr/share/jenkins/ref/secrets
ADD .temp/users /usr/share/jenkins/ref/users
ADD .temp/plugins.txt /usr/share/jenkins/plugins.txt

# Workaround for 'Lockfile creation - File not found' error
RUN xargs /usr/local/bin/install-plugins.sh < /usr/share/jenkins/plugins.txt

RUN echo 2.0 > /usr/share/jenkins/ref/jenkins.install.UpgradeWizard.state

ENTRYPOINT ["/bin/tini", "--", "/usr/local/bin/jenkins.sh"]
