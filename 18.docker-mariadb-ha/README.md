# mariadb HA replication

## maste-slave 구성

### 0. mariadb 간의 name 으로 연결이 가능하도록 네트워크 생성

```sh
make network
docker network ls
```
### 1. mariadb 의 master/slave 구성

```sh
make mariadb1
sleep 10
make mariadb2
sleep 1
make maxscale1
sleep 1
make maxscale2
```

### 2. client test

- client 실행

```sh
make cli1
```

- query 테스트

```sql
use AGENT_DB;
select * from TBL_CF_AGT_CODE;

DELETE FROM TBL_CF_AGT_CODE;

INSERT INTO `TBL_CF_AGT_CODE` VALUES ('T_001', 'ID_001', 'NAME_0001', 'VALUE_001', 1);
INSERT INTO `TBL_CF_AGT_CODE` VALUES ('T_002', 'ID_002', 'NAME_0002', 'VALUE_002', 2);
COMMIT;

INSERT INTO `TBL_CF_AGT_CODE` VALUES ('T_003', 'ID_003', 'NAME_0003', 'VALUE_003', 3);
INSERT INTO `TBL_CF_AGT_CODE` VALUES ('T_004', 'ID_004', 'NAME_0004', 'VALUE_004', 4);
COMMIT;
```

- 문제점
    - master 에서만 DELETE, INSERT 를 하면 slave 에 반영됨
    - slave 에서 DELETE, INSERT 를 실행하면 동기화가 안됨
    - function 을 생성하면, 동기화 안됨

### 3. maxscale 확인

- maxscale 이 DB HA Proxy 로 동작하도록 연동하면, maxscale 를 통해 DB Query를 실행하면, mariadb failover 에 대응이 가능함

- 참고
    - [Mariadb MaxScale 구성하기](https://sarc.io/index.php/mariadb/1474-maxscale)
    - [MariaDB, Galera Cluster, MaxScale 전체 정리](https://ongamedev.tistory.com/entry/MariaDB-Galera-Cluster-MaxScale-%EC%A0%84%EC%B2%B4-%EC%A0%95%EB%A6%AC)
    - [[MariaDB] Maxscale을 활용한 Auto-Failover 구성하기](https://yeti.tistory.com/137)

- maxscale 동작 확인

```sh
docker exec -it maxscale1 maxctrl

list servers
list services
list monitors

show servers
show services
```

- maxscale 를 통한 mysql 연동

```sh
make cli

mysql -uagent -pagent.123 -P4406 -hmaxscale1 -e "use AGENT_DB;select * from TBL_CF_AGT_CODE;"

mysql -uagent -pagent.123 -P4406 -hmaxscale1 -e "use AGENT_DB;DELETE FROM TBL_CF_AGT_CODE;INSERT INTO TBL_CF_AGT_CODE VALUES ('T_001', 'ID_001', 'NAME_0001', 'VALUE_001', 1);INSERT INTO TBL_CF_AGT_CODE VALUES ('T_002', 'ID_002', 'NAME_0002', 'VALUE_002', 2);COMMIT;select * from TBL_CF_AGT_CODE;"
```
