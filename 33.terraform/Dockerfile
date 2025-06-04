ARG TF_VER=1.12
ARG CAPA_VER=2.7.1
FROM hashicorp/terraform:${TF_VER}

# FROM 이후에 ARG CAPA_VER 를 다시 선언해야 이 이후에 사용할 수 있음
ARG CAPA_VER

LABEL maintainer="yongs2@hotmail.com"

RUN apk add --no-cache jq docker curl

# for localstack
RUN apk add --no-cache python3 py3-virtualenv make zip \
    && python3 -m venv /venv \
    && . /venv/bin/activate \
    && pip install --upgrade pip \
    && pip install awscli && pip install awscli-local \
    && pip install terraform-local

# for cluster-api-provider-aws
RUN curl -L https://github.com/kubernetes-sigs/cluster-api-provider-aws/releases/download/v${CAPA_VER}/clusterawsadm-linux-amd64 -o /tmp/clusterawsadm \
    && chmod +x /tmp/clusterawsadm \
    && mv /tmp/clusterawsadm /usr/local/bin \
    && clusterawsadm version

ENV PATH="/venv/bin:$PATH"

WORKDIR /workspace

CMD [ "/bin/sh" ]
