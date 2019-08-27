FROM docker.io/centos:7.1.1503

USER root

RUN yum clean all \
    && yum repolist \
    && yum -y swap fakesystemd systemd

RUN yum -y update
RUN yum -y install tar unzip vi vim
RUN yum -y install apr apr-util apr-devel apr-util-devel
RUN yum -y install net-tools curl openssl elinks locate python-setuptools
RUN yum -y install subversion
RUN yum -y install gcc-c++
RUN yum clean all

CMD ["/bin/bash"]
