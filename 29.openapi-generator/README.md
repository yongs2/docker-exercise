## openapi-generator 를 기준을 3gpp yaml 파일 변환 작업

- openapi-generator 를 fork 를 진행해서 작업 환경 구성

```sh
git clone https://github.com/yongs2/openapi-generator
```

- [docker 로 빌드 환경](https://github.com/OpenAPITools/openapi-generator/blob/master/Dockerfile)

```sh
cd $WORKSPACE;
docker run -it --rm \
    -v `pwd`/openapi-generator-m2:/root/.m2 \
    -v `pwd`/openapi-generator:/root/src \
    -v `pwd`/5GC_APIs:/local \
    -v `pwd`/openapi:/out \
    -w /root/src \
    --name mvn-jdk \
    maven:3.6.3-jdk-11-openj9 /bin/bash
```

- 빌드 및 변환 작업

```sh
cd /root/src
mvn -am -pl "modules/openapi-generator-cli" package -DskipTests=true -Dmaven.javadoc.skip=true -Djacoco.skip=true

export JAVA_OPTS="${JAVA_OPTS} --global-property debugModels,debugOperations"
export JAVA_OPTS="${JAVA_OPTS} -Dlog.level=debug"

cd /local

# test for required:[] in oneOf
YAML_NAME=TS29122_NIDD

# test for inline_object, contentType
YAML_NAME=TS29542_Nsmf_NIDD

# test for Nullable
YAML_NAME=TS29512_Npcf_SMPolicyControl

# test for multiple oneOf (SubscriptionData.subscrCond)
YAML_NAME=TS29510_Nnrf_NFManagement

# test for allOf pattern(Ipv6Addr, Ipv6AddrRm, Ipv6Prefix, Ipv6PrefixRm)
YAML_NAME=TS29571_CommonData.yaml

# test command commonly
mkdir -p /out/${YAML_NAME}/;
java -Dlog.level=debug -jar /root/src/modules/openapi-generator-cli/target/openapi-generator-cli.jar generate -i /local/${YAML_NAME}.yaml -g go --additional-properties=isGoSubmodule=true,enumClassPrefix=true,generateInterfaces=true -o /out/${YAML_NAME} >/out/${YAML_NAME}/oag.log 2>&1
```

- 위  기능을 시험하기 위한 개별 시험

```sh
# test for allOf pattern (Ipv4Addr)
YAML_NAME=ts_allof_pattern
mkdir -p /out/${YAML_NAME}/;
java -Dlog.level=debug -jar /root/src/modules/openapi-generator-cli/target/openapi-generator-cli.jar generate -i /out/${YAML_NAME}.yaml -g go --additional-properties=isGoSubmodule=true,enumClassPrefix=true,generateInterfaces=true -o /out/${YAML_NAME} >/out/${YAML_NAME}/oag.log 2>&1
```

## 별도의 패치 버전을 기준으로 비교 시험

- [Resolve several issues in generated Go code](https://github.com/OpenAPITools/openapi-generator/pull/8491)
- [Pull Request 소스](https://github.com/aeneasr/openapi-generator/tree/fix-go) 를 기준으로 비교
- [fix unnecessary allOf models](https://github.com/leo-sale/openapi-generator/commits/fix-unnecessary-models) : 반영하였으나, allOf 문제는 아직 해결 안됨
- [Readonly attribute](https://github.com/CiscoM31/openapi-generator)


- docker 빌드 환경

```sh
git clone -b fix-go --single-branch https://github.com/aeneasr/openapi-generator openapi-generator-fix-go

cd $WORKSPACE;
docker run -it --rm \
    -v `pwd`/openapi-generator-m2:/root/.m2 \
    -v `pwd`/openapi-generator-latest:/root/src \
    -v `pwd`/5GC_APIs:/local \
    -v `pwd`/openapi:/out \
    --name mvn-jdk-latest \
    maven:3.6.3-jdk-11-openj9 /bin/bash

docker exec -it mvn-jdk-latest /bin/bash
```

- 빌드 및 변환 작업

```sh
cd /root/src
mvn -am -pl "modules/openapi-generator-cli" package -DskipTests=true -Dmaven.javadoc.skip=true -Djacoco.skip=true

java -Dlog.level=info -jar /root/src/modules/openapi-generator-cli/target/openapi-generator-cli.jar generate -i /local/TS29122_NIDD.yaml -g go -o /out/fix-go
```

- inline_resolver 참고

```sh
git clone -b inline-resolver --single-branch https://github.com/fantavlik/openapi-generator openapi-generator-inline-resolver
```

- multipart/ mediatype 참고

```sh
https://github.com/OpenAPITools/openapi-generator/pull/5613
https://github.com/zhemant/openapi-generator/tree/mpandencoding
```
  - multipart 부분을 이 소스를 참고하여 수정하려고 했으나, 소스 차이가 많아서 적용 실패
  - TS29542_Nsmf_NIDD.yaml 은 openapi-generator-cli 호출 후 수작업으로 deliverRequest 의 multipart 부분을 수작업이 

- fix-go 를 참조하여, GoClientCodegen.java 에서 array와 map 에 Nullable 을 추가
  - TS29512_Npcf_SMPolicyControl 의 PccRule 의 refChgData 를 NullArrayString 으로 변환할 수 있도록 보완

## upstream 변경 사항 반영

- remote 의 최신 변경 사항을 master 에 반영

```sh
git checkout master
git remote add upstream https://github.com/OpenAPITools/openapi-generator
git remote -v
git fetch upstream
git checkout master
git merge upstream/master
git push
```

- 현재 작업 중인 branch 는 fix-go-oneof

```sh
git checkout fix-go-oneof
git merge master

```

## 변환 후 model 및 api 테스트

```sh
cd $WORKSPACE;
docker run -it --rm \
    -v `pwd`/5GC_APIs:/local \
    -v `pwd`/openapi:/out \
    --name golang \
    golang:latest /bin/bash
```
