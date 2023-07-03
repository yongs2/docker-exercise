ARG REGISTRY_URL=docker.io/yongs2
ARG ROCKY_VERSION=8.5.20220308
FROM ${REGISTRY_URL}/rockylinux:${ROCKY_VERSION}

LABEL maintainer="yongs2@hotmail.com"

# install essential dev tools
RUN dnf -y install gcc make git

# install go, curl -L https://golang.org/VERSION?m=text
ARG GO_VERSION=1.16.6
ENV GOPATH=/go
ENV GO111MODULE=on
ENV GOTRACEBACK=crash
ENV PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

RUN export OS=`uname | tr A-Z a-z` && \
    export ARCH=`uname -m | sed -E 's/^(aarch64|aarch64_be|armv6l|armv7l|armv8b|armv8l)$$/arm64/g' | sed -E 's/^x86_64$$/amd64/g'` && \
    export DOWNLOAD_FILE=go${GO_VERSION}.${OS}-${ARCH}.tar.gz && \
    /usr/bin/curl -L https://dl.google.com/go/${DOWNLOAD_FILE} -o /tmp/${DOWNLOAD_FILE} && \
    /usr/bin/rm -rf /usr/local/go && tar -C /usr/local -xzf /tmp/${DOWNLOAD_FILE} && \
    /usr/local/go/bin/go version

# install golangci/golangci-lint
RUN export LINT_VERSION=`curl -s https://api.github.com/repos/golangci/golangci-lint/releases/latest | grep tag_name | cut -d '"' -f 4` && \
    /usr/bin/curl -sSfL https://raw.githubusercontent.com/golangci/golangci-lint/master/install.sh | sh -s -- -b ${GOPATH}/bin ${LINT_VERSION}

# Install goreportcard-cli
RUN cd /tmp && \
    /usr/bin/git clone https://github.com/gojp/goreportcard.git && \
    cd goreportcard && \
    /usr/bin/make install && \
    /usr/local/go/bin/go install ./cmd/goreportcard-cli

# "ulimit -c unlimited" for GOTRACEBACK=crash
# install delve
RUN /usr/local/go/bin/go install github.com/go-delve/delve/cmd/dlv@latest

# for system monitoring
RUN dnf -y install net-tools lsof jq which openssh-clients

# yq 설치
RUN export OS=`uname | tr A-Z a-z` && \
    export ARCH=`uname -m | sed -E 's/^(aarch64|aarch64_be|armv6l|armv7l|armv8b|armv8l)$$/arm64/g' | sed -E 's/^x86_64$$/amd64/g'` && \
    export YQ_VERSION=`curl -s https://api.github.com/repos/mikefarah/yq/releases/latest | grep tag_name | cut -d '"' -f 4` && \
    export BINARY=yq_${OS}_${ARCH} && echo "BINARY=${BINARY}" && \
    export DOWNLOAD_FILE=${BINARY}.tar.gz && echo "DOWNLOAD_FILE=${DOWNLOAD_FILE}" && \
    /usr/bin/curl -L https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/${DOWNLOAD_FILE} -o /tmp/${DOWNLOAD_FILE} && \
    tar -zxvf /tmp/${DOWNLOAD_FILE} -C /usr/local/bin && \
    mv /usr/local/bin/${BINARY} /usr/local/bin/yq

# set timezone KST
RUN ln -snf /usr/share/zoneinfo/Asia/Seoul /etc/localtime \
    && echo "Asia/Seoul" > /etc/timezone

WORKDIR /go/src

CMD [ "/bin/bash" ]
