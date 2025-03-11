ARG GO_VERSION=1.22.0
# Debian GNU/Linux 12 (bookworm)
FROM golang:${GO_VERSION}

LABEL maintainer="yongs2@hotmail.com"

# FIXME: Switch to Debian Docker repo to fix 404 error (https://download.docker.com/linux/ubuntu)
# Add Docker's official GPG key:
RUN apt-get -y update \
    && apt-get -y install ca-certificates curl \
    && install -m 0755 -d /etc/apt/keyrings \
    && curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc \
    && chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
RUN echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt-get -y update \
    && apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# set timezone KST
RUN ln -snf /usr/share/zoneinfo/Asia/Seoul /etc/localtime \
    && echo "Asia/Seoul" > /etc/timezone

# install golangci-lint
RUN LATEST_VERSION=`curl -s "https://api.github.com/repos/golangci/golangci-lint/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/'` \
    && curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/HEAD/install.sh | sh -s -- -b $(go env GOPATH)/bin ${LATEST_VERSION}

# install gosec
RUN LATEST_VERSION=`curl -s "https://api.github.com/repos/securego/gosec/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/'` \
    && curl -sfL https://raw.githubusercontent.com/securego/gosec/master/install.sh | sh -s -- -b $(go env GOPATH)/bin ${LATEST_VERSION}

WORKDIR /go/src

CMD [ "/bin/bash" ]
