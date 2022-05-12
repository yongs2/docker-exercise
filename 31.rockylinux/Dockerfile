ARG VERSION=8.5.20220308
FROM docker.io/rockylinux:${VERSION}

LABEL maintainer="yongs2"

# Update for security
RUN dnf -y upgrade glibc glibc-minimal-langpack openssl-libs
