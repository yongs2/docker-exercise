ARG TF_VER=1.4.2
FROM hashicorp/terraform:${TF_VER}

LABEL maintainer="yongs2@hotmail.com"

RUN apk add jq docker curl

# for localstack
RUN apk add python3 make zip \
    && curl https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py \
    && python /tmp/get-pip.py \
    && pip install awscli && pip install awscli-local \
    && pip install terraform-local

WORKDIR /workspace

CMD [ "/bin/sh" ]
