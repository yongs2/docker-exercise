#!/bin/sh
# Docker 로 기동된 이후에 실행할 작업들

MYSQL_USR=root
MYSQL_PWD=jdnroot

run_mariadb() {
	/usr/libexec/mariadb-prepare-db-dir 
	/usr/bin/mysqld_safe --basedir=/usr &
	/usr/bin/mysqladmin -u ${MYSQL_USR} password ${MYSQL_PWD}
}

run_hss() {
	mysql -u ${MYSQL_USR} -p${MYSQL_PWD} < /opt/OpenIMSCore/FHoSS/scripts/hss_db.sql
	mysql -u ${MYSQL_USR} -p${MYSQL_PWD} < /opt/OpenIMSCore/FHoSS/scripts/userdata.sql
	mysql -u ${MYSQL_USR} -p${MYSQL_PWD} < /opt/OpenIMSCore/ser_ims/cfg//icscf.sql

	cd /opt/OpenIMSCore/FHoSS/deploy; 
	
	/opt/OpenIMSCore/FHoSS/deploy/startup.sh
}

run_mariadb
run_hss

# end of script