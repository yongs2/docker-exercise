FROM node:alpine

ENV EMAIL your@mail.addr
ENV DOMAIN server.tld

ADD server.js /server.js
ADD gencerts.sh /gencerts.sh
RUN chmod 755 /gencerts.sh \
    && apk add --no-cache git vim certbot acme-client openssl ca-certificates \
    && mkdir -p /usr/src/app \
    && cd /usr/src/app \
    && git clone https://github.com/muaz-khan/RTCMultiConnection.git \
    && cd RTCMultiConnection \
    && npm install --production \
    && cd .. \
    && npm install -g light-server

WORKDIR /usr/src/app/RTCMultiConnection
EXPOSE 80 443 9001
VOLUME ["/usr/src/app"]
CMD ["npm","start"]
