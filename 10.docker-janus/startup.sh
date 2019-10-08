#!/bin/bash

BASE_DIR=/opt/janus

PATH=${BASE_DIR}/bin:${PATH}
LD_LIBRARY_PATH=/usr/lib:${BASE_DIR}/lib:${BASE_DIR}/lib/janus/transports:${BASE_DIR}/lib/janus/plugins:${LD_LIBRARY_PATH}

CERT_DIR=${BASE_DIR}/share/janus/certs
SSL_KEY=${CERT_DIR}/mycert.key
SSL_CERT=${CERT_DIR}/mycert.pem

echo "PATH=${PATH}"
echo "LD_LIBRARY_PATH=${LD_LIBRARY_PATH}"

# Patch Config to enable Event Handler
#CFG_EVENT='/root/janus/etc/janus/janus.eventhandler.sampleevh.cfg'
#sed 's/enabled = no/enabled = yes/1' -i $CFG_EVENT
#echo 'backend = http://localhost:7777' >> $CFG_EVENT

CFG_JANUS="${BASE_DIR}/etc/janus/janus.jcfg"
/bin/sed 's/#broadcast = true/broadcast = true/1' -i $CFG_JANUS

CFG_HTTPS="${BASE_DIR}/etc/janus/janus.transport.http.jcfg"
/bin/sed 's/https = false/https = true/1' -i $CFG_HTTPS
/bin/sed 's/#secure_port = 8089/secure_port = 8089/1' -i $CFG_HTTPS

/bin/sed -e "s|#cert_pem = \"/path/to/cert.pem\"|cert_pem = \"${SSL_CERT}\"|" -i $CFG_HTTPS
/bin/sed -e "s|#cert_key = \"/path/to/key.pem\"|cert_key = \"${SSL_KEY}\"|" -i $CFG_HTTPS

http-server ${BASE_DIR}/share/janus/demos/ --key ${SSL_KEY} --cert ${SSL_CERT} -d false -p 8080 -c-1 --ssl &

# Start Janus Gateway in forever mode, -d 7 for debug
${BASE_DIR}/bin/janus --stun-server=stun.l.google.com:19302 -L /var/log/meetecho --rtp-port-range=10000-10200
