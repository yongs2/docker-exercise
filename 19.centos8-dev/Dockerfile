FROM docker.io/centos:8

USER root

RUN yum clean all \
    && yum repolist \
    && yum -y swap fakesystemd systemd

RUN dnf -y update \
    && dnf group -y install "Development Tools"

WORKDIR /root

ENV PRJ_HOME /root/project
ENV SYSTEM_CFLAGS "-O3"
ENV SYSTEM_DEFINE "-D__linux -m64"
ENV PRJ_DEFINE "-D__DEBUG__"

CMD ["/bin/bash"]
