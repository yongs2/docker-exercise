# bulid stage
FROM golang:1.14.0-buster AS build

LABEL MAINTAINER=yongs2@hotmail.com

# unixodbc
RUN apt-get update \
    && apt-get -y install unixodbc unixodbc-dev odbcinst \
    && apt-get -y install cmake build-essential libssl-dev

WORKDIR /root

RUN mkdir -p /root/odbc_package \
    && cd /root/odbc_package \
    && echo "Downlaoding mariadb-connector-c" \
    && git clone https://github.com/MariaDB/mariadb-connector-odbc.git \
    \
    && echo "build" \
    && cd mariadb-connector-odbc \
    && cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DWITH_OPENSSL=true -DCMAKE_INSTALL_PREFIX=/usr/local -LH  \
    && make \
    && make install \
    && make package

# final stage
FROM golang:1.14.0-buster

# unixodbc
RUN apt-get update \
    && apt-get -y install unixodbc unixodbc-dev odbcinst

RUN mkdir /root/odbc_package

COPY --from=build /root/odbc_package/mariadb-connector-odbc/*.gz /root/odbc_package/

RUN cd /root/odbc_package \
    && tar -xvzf *.gz \
    && install lib/libmaodbc.so /usr/lib/

ADD odbcinst.ini /etc
ADD odbc.ini /etc

EXPOSE 3306

CMD [ "/bin/bash" ]
