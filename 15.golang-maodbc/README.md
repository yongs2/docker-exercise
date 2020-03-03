# golang-maodbc

- golang with MariaDB Connector/ODBC 

## golang docker

- run golang with latest version
```sh
docker run --rm -it --name golang-odbc golang:latest /bin/bash

cat /etc/os-release
go version

export ODBC_VERSION=3.1.6;
# debian strech 64 bit
export LINUX_OS=debian-x86_64;
mkdir odbc_package
cd odbc_package
wget https://downloads.mariadb.com/Connectors/odbc/connector-odbc-${ODBC_VERSION}/mariadb-connector-odbc-${ODBC_VERSION}-ga-${LINUX_OS}.tar.gz

tar -xvzf mariadb-connector-odbc-${ODBC_VERSION}-ga-${LINUX_OS}.tar.gz
sudo install lib64/libmaodbc.so /usr/lib64/
```

- 위와 같이 설치하면 libmaodbc.so 에서 참조하는 ssl 버전은 debian 9 (stretch) 버전이어서, golang이 설치된 debian 10 (buster) 에 설치된 ssl 버전이 다름
```sh
root@57757333dead:/go/odbc_package/lib# ldd libmaodbc.so
	linux-vdso.so.1 (0x00007ffcbf066000)
	libodbcinst.so.2 => /usr/lib/x86_64-linux-gnu/libodbcinst.so.2 (0x00007fb9b3fbf000)
	libm.so.6 => /lib/x86_64-linux-gnu/libm.so.6 (0x00007fb9b3e3c000)
	libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007fb9b3e37000)
	libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007fb9b3e16000)
	libssl.so.1.0.0 => not found
	libcrypto.so.1.0.0 => not found
	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fb9b3c53000)
	libltdl.so.7 => /usr/lib/x86_64-linux-gnu/libltdl.so.7 (0x00007fb9b3c48000)
	/lib64/ld-linux-x86-64.so.2 (0x00007fb9b4481000)
root@57757333dead:/go/odbc_package/lib# ldd /usr/bin/openssl
	linux-vdso.so.1 (0x00007fffc5b6c000)
	libssl.so.1.1 => /usr/lib/x86_64-linux-gnu/libssl.so.1.1 (0x00007fb77ceab000)
	libcrypto.so.1.1 => /usr/lib/x86_64-linux-gnu/libcrypto.so.1.1 (0x00007fb77cbc2000)
	libdl.so.2 => /lib/x86_64-linux-gnu/libdl.so.2 (0x00007fb77cbbd000)
	libpthread.so.0 => /lib/x86_64-linux-gnu/libpthread.so.0 (0x00007fb77cb9c000)
	libc.so.6 => /lib/x86_64-linux-gnu/libc.so.6 (0x00007fb77c9db000)
	/lib64/ld-linux-x86-64.so.2 (0x00007fb77cffb000)
```

- golang 에서 libmaodbc.so 를 빌드해야 함
```sh
cd ~/odbc_package
git clone https://github.com/MariaDB/mariadb-connector-odbc.git

apt-get -y install cmake build-essential
cmake -G "Unix Makefiles" -DCMAKE_BUILD_TYPE=Release -DWITH_OPENSSL=true -DCMAKE_INSTALL_PREFIX=/usr/local -LH
make; make install;
ls -la /usr/local/lib/libmaodbc.so
ldd /usr/local/lib/libmaodbc.so

cat << EOF | tee /etc/odbcinst.ini
[MariaDB]
Driver      = libmaodbc.so
Description = MariaDB ODBC Connector
EOF
cat << EOF | tee /etc/odbc.ini
[testdb]
Description         = MariaDB testdb
Driver              = MariaDB
Database            = testdb
Server              = 172.17.0.4
Uid                 = root
Password            = root
Port                = 3306
EOF
/usr/bin/isql -v testdb
```

- Reference
    - [How to install and configure MariaDB unixODBC driver](https://blog.sleeplessbeastie.eu/2018/01/08/how-to-install-and-configure-mariadb-unixodbc-driver/)
