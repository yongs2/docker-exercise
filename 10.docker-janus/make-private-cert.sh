#!/bin/bash
umask 077

answers() {
    echo --
    echo SomeState
    echo SomeCity
    echo SomeOrganization
    echo SomeOrganizationalUnit
    echo localhost.localdomain
    echo root@localhost.localdomain
}

BASE_DIR=/opt/janus
CERT_DIR=${BASE_DIR}/share/janus/certs/
SSL_KEY=${CERT_DIR}/mycert.key
SSL_CERT=${CERT_DIR}/mycert.pem

mkdir -p ${BASE_DIR}/share/janus/certs/
answers | /usr/bin/openssl req -newkey rsa:2048 -keyout ${SSL_KEY} -nodes -x509 -days 365 -out ${SSL_CERT}
