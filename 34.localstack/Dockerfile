ARG LS_VER=2.0.0
FROM localstack/localstack:${LS_VER}

LABEL maintainer="yslee1@ntels.com"

# Add path to localstack
ENV PATH=/opt/code/localstack/bin:$PATH

# install util
RUN apt update \
    && apt -y install jq net-tools tree

# install terraform and tflocal
RUN curl -L https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list \
    && apt update && apt install terraform \
    && pip install --upgrade pip \
    && pip install terraform-local
