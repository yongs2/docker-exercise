FROM node:alpine

RUN apk add --no-cache git vim openssl \
	&& mkdir -p /usr/src/app \
	&& cd /usr/src/app \
	&& git clone https://github.com/lulop-k/kurento-rtsp2webrtc.git \
	&& npm install -g bower http-server \
	&& cd kurento-rtsp2webrtc \
	&& bower install --allow-root \
	&& cd .. \
	&& openssl req -newkey rsa:2048 -new -nodes -x509 -days 3650 -subj '//CN=www.mydom.com\O=My Company LTD.\C=US' -keyout key.pem -out cert.pem

WORKDIR /usr/src/app/

CMD ["http-server", "-S", "-C", "cert.pem", "kurento-rtsp2webrtc"]

EXPOSE 80 443 8080
