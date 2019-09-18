FROM cytopia/bind
MAINTAINER yongs2@j-din.com

ADD ./named.conf.enum /etc/bind/
ADD ./db.e164.arpa /etc/bind/
COPY ./docker-entrypoint.sh /

###
### Ports
###
EXPOSE 53
EXPOSE 53/udp

####
#### Entrypoint
####
ENTRYPOINT ["/docker-entrypoint.sh"]
