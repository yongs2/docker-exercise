ARG TF_VER=1.12
FROM hashicorp/terraform:${TF_VER}

LABEL maintainer="yongs2@hotmail.com"

RUN apk add --no-cache jq docker curl

# for localstack
RUN apk add --no-cache python3 py3-virtualenv make zip \
    && python3 -m venv /venv \
    && . /venv/bin/activate \
    && pip install --upgrade pip \
    && pip install awscli && pip install awscli-local \
    && pip install terraform-local

ENV PATH="/venv/bin:$PATH"

WORKDIR /workspace

CMD [ "/bin/sh" ]
