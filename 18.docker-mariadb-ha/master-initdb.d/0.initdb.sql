-- for MASTER
RESET MASTER;

-- for MASTER USER
CREATE USER maxuser@'%' identified by 'password';
GRANT ALL ON *.* to maxuser@'%';

-- DROP DATABASE AGENT_DB;
CREATE DATABASE AGENT_DB ; 

-- DROP USER 'agent''@'localhost';
CREATE USER 'agent'@'localhost' IDENTIFIED BY 'agent.123';
CREATE USER 'agent'@'%' IDENTIFIED BY 'agent.123';

GRANT ALL PRIVILEGES on AGENT_DB.* TO 'agent'@'localhost';
GRANT ALL PRIVILEGES on AGENT_DB.* TO 'agent'@'%';
GRANT ALL PRIVILEGES on *.* TO 'agent'@'localhost';
GRANT ALL PRIVILEGES on *.* TO 'agent'@'%';
FLUSH PRIVILEGES;

GRANT ALL ON AGENT_DB.* TO 'agent'@'%' IDENTIFIED BY 'agent.123';
GRANT ALTER,CREATE,DELETE,DROP,INDEX,INSERT,SELECT,UPDATE ON AGENT_DB.* TO 'agent'@'%' IDENTIFIED BY 'agent.123';
GRANT ALTER,CREATE,DELETE,DROP,INDEX,INSERT,SELECT,UPDATE ON AGENT_DB.* TO 'agent'@'localhost' IDENTIFIED BY 'agent.123';

-- [mariadb] function 생성시 ERROR 1418(HY000)
SET GLOBAL log_bin_trust_function_creators = 1;
