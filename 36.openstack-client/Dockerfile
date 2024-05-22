# Refer to https://hub.docker.com/r/openstacktools/openstack-client/dockerfile
# https://wiki.debian.org/LTS
# Debian 11 Bullseye
# Debian 12 Bookworm
# docker run -it python:3.12-bookworm /bin/bash
ARG PYTHON_VERSION=3.12-bookworm
FROM docker.io/python:${PYTHON_VERSION}

RUN apt-get update && apt-get -yq install \
    gettext \
    jq \
    python3-aodhclient \
    python3-barbicanclient \
    python3-cinderclient \
    python3-cloudkittyclient \
    python3-designateclient \
    python3-gnocchiclient \
    python3-octaviaclient \
    python3-osc-placement \
    python3-openstackclient \
    python3-pankoclient \
    zip \
  && rm -rf /var/lib/apt/lists/*

CMD /bin/bash
