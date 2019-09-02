#!/bin/sh

light-server -s /usr/src/app -p 80 &

# Initial certificate request, but skip if cached
if [ ! -f /etc/letsencrypt/live/${DOMAIN}/fullchain.pem ]; then
  certbot certonly --webroot \
   --webroot-path=/usr/src/app \
   --domain ${DOMAIN} \
   --email "${EMAIL}" --agree-tos
else
  certbot renew
fi

killall light-server
sed -i "s/DOMAIN/${DOMAIN}/g" /server.js
cp -f /server.js /usr/src/app/RTCMultiConnection/server.js
