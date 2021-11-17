ARG DOCKER_VERSION=20.10.10-alpine3.14
FROM docker:${DOCKER_VERSION}

# install tool
RUN apk add --update --no-cache curl ca-certificates bash git make

# install helm
ENV VERIFY_CHECKSUM=false
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
    && chmod +x get_helm.sh \
    && ./get_helm.sh

# install kubectl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" \
    && chmod +x kubectl \
    && mv kubectl /usr/bin/kubectl

# install yq
ARG YQ_VERSION=4.14.1
ENV YQ_BINARY=yq_linux_amd64
RUN curl -LO "https://github.com/mikefarah/yq/releases/download/v${YQ_VERSION}/${YQ_BINARY}.tar.gz" \
    && tar -zxvf ${YQ_BINARY}.tar.gz \
    && mv ${YQ_BINARY} /usr/bin/yq

WORKDIR /apps
