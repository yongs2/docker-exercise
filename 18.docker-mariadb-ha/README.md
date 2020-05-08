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
