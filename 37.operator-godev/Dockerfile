ARG GO_VERSION=1.21.10
# Debian GNU/Linux 12 (bookworm)
FROM golang:${GO_VERSION}

LABEL maintainer="yongs2@hotmail.com"

# install packages for docker
RUN apt -y update \
    && apt -y install docker.io

# install kubectl
RUN /usr/bin/curl -LO "https://dl.k8s.io/release/$(/usr/bin/curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# install operator-sdk cli
RUN export ARCH=$(case $(uname -m) in x86_64) echo -n amd64 ;; aarch64) echo -n arm64 ;; *) echo -n $(uname -m) ;; esac) \
    && export OS=$(uname | awk '{print tolower($0)}') \
    && LATEST_VERSION=`/usr/bin/curl -s "https://api.github.com/repos/operator-framework/operator-sdk/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/'` \
    && export OPERATOR_SDK_DL_URL=https://github.com/operator-framework/operator-sdk/releases/download/${LATEST_VERSION} \
    && /usr/bin/curl -LO ${OPERATOR_SDK_DL_URL}/operator-sdk_${OS}_${ARCH} \
    && chmod +x operator-sdk_${OS}_${ARCH} && mv operator-sdk_${OS}_${ARCH} /usr/local/bin/operator-sdk

# install k3d
RUN curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# set timezone KST
RUN ln -snf /usr/share/zoneinfo/Asia/Seoul /etc/localtime \
    && echo "Asia/Seoul" > /etc/timezone

WORKDIR /go/src

CMD [ "/bin/bash" ]
