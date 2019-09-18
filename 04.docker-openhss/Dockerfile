FROM docker.io/centos:7

MAINTAINER yongs2@j-din.com

# https://www.openimscore.com/installation-guide
# https://yongsukim.blogspot.com/2014/10/centos-7-openims-sipp-ims.html

ENV LANG=en_US.utf8 \
    LC_ALL=en_US.utf8 \
    JAVA_HOME=/usr

RUN    yum update -y \
    && yum groupinstall -y "Development Tools" \
    && yum install -y svn gdb libaio openssh-clients java-1.7.0-openjdk ant libxml* mariadb* libcurl* \
    && yum clean all

RUN    mkdir -p /opt/OpenIMSCore/FHoSS  \
    && cd /opt/OpenIMSCore \
    && svn checkout https://svn.code.sf.net/p/openimscore/code/FHoSS/trunk FHoSS

RUN    mkdir -p /opt/OpenIMSCore/ser_ims  \
    && cd /opt/OpenIMSCore \
    && svn checkout https://svn.code.sf.net/p/openimscore/code/ser_ims/trunk ser_ims

RUN    cd /opt/OpenIMSCore/FHoSS \
    && ant compile deploy

RUN    cd /opt/OpenIMSCore/ser_ims \
    && make install-libs all

RUN    rm -rf /var/lib/mysql && rm -rf  /var/run/mysqld \
    && mkdir -p /var/lib/mysql /var/run/mysqld \
    && chown -R mysql:mysql /var/lib/mysql /var/run/mysqld \
    && chmod 777 /var/run/mysqld

RUN    cd /opt/OpenIMSCore/ \
    && cp /opt/OpenIMSCore/ser_ims/cfg/*.cfg /opt/OpenIMSCore/ \
    && cp /opt/OpenIMSCore/ser_ims/cfg/*.xml /opt/OpenIMSCore/ \
    && cp /opt/OpenIMSCore/ser_ims/cfg/*.sh /opt/OpenIMSCore/ \
    && find /opt/OpenIMSCore/FHoSS/deploy -name "DiameterPeerHSS.xml" -type f -exec sed -i 's/127.0.0.1/0.0.0.0/g' {} \; \
    && find /opt/OpenIMSCore/FHoSS/deploy -name "hss.properties" -type f -exec sed -i 's/127.0.0.1/0.0.0.0/g' {} \;

ADD    ./docker_run.sh /opt/OpenIMSCore/

EXPOSE 22 3868 8088

# Web Login : http://ip:8088 (hssAdmin/hss)
CMD [ "sh", "/opt/OpenIMSCore/docker_run.sh" ]
