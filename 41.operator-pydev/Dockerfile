ARG PYTHON_VERSION=3.11
# Debian GNU/Linux 12 (bookworm)
FROM python:${PYTHON_VERSION}

LABEL maintainer="yongs2@hotmail.com"

# install packages for docker
RUN apt -y update \
    && apt -y install docker.io

# install kubectl
RUN /usr/bin/curl -LO "https://dl.k8s.io/release/$(/usr/bin/curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# 작업 디렉토리
WORKDIR /app

# 의존성 먼저 복사해서 캐시 활용
COPY requirements.txt .

# 패키지 설치
RUN pip install --no-cache-dir --upgrade pip \
 && pip install --no-cache-dir -r requirements.txt

# set timezone KST
RUN ln -snf /usr/share/zoneinfo/Asia/Seoul /etc/localtime \
    && echo "Asia/Seoul" > /etc/timezone

CMD [ "/bin/bash" ]
