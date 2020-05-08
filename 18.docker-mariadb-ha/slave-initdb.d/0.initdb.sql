STOP SLAVE;
RESET MASTER;
RESET SLAVE;
RESET SLAVE ALL;
SET GLOBAL gtid_slave_pos = '';
CHANGE MASTER TO MASTER_HOST='mariadb1', MASTER_PORT=3306, MASTER_USER='maxuser', MASTER_PASSWORD='password', MASTER_USE_GTID=slave_pos;
START SLAVE;

-- [mariadb] function 생성시 ERROR 1418(HY000)
SET GLOBAL log_bin_trust_function_creators = 1;
