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
java -Dlog.level=debug -jar /root/src/modules/openapi-generator-cli/target/openapi-generator-cli.jar generate -i /local/TS29122_NIDD.yaml -g go --additional-properties=isGoSubmodule=true,enumClassPrefix=true,generateInterfaces=true -o /local/out/TS29122_NIDD >/local/out/oag.log 2>&1

# test for inline_object, contentType
java -Dlog.level=debug -jar /root/src/modules/openapi-generator-cli/target/openapi-generator-cli.jar generate -i /local/TS29542_Nsmf_NIDD.yaml -g go --additional-properties=isGoSubmodule=true,enumClassPrefix=true,generateInterfaces=true -o /local/out/TS29542_Nsmf_NIDD >/local/out/oag.log 2>&1

# test for Nullable
java -Dlog.level=debug -jar /root/src/modules/openapi-generator-cli/target/openapi-generator-cli.jar generate -i /local/TS29512_Npcf_SMPolicyControl.yaml -g go --additional-properties=isGoSubmodule=true,enumClassPrefix=true,generateInterfaces=true -o /local/out/TS29512_Npcf_SMPolicyControl >/local/out/oag.log 2>&1

java -Dlog.level=info -jar /root/src/modules/openapi-generator-cli/target/openapi-generator-cli.jar generate -i /local/TS29122_NIDD.yaml -g go -o /local/out/go >oag.log 2>&1
```

## 별도의 패치 버전을 기준으로 비교 시험

- [Resolve several issues in generated Go code](https://github.com/OpenAPITools/openapi-generator/pull/8491)
- [Pull Request 소스](https://github.com/aeneasr/openapi-generator/tree/fix-go) 를 기준으로 비교

- docker 빌드 환경

```sh
git clone -b fix-go --single-branch https://github.com/aeneasr/openapi-generator openapi-generator-fix-go

docker run -it --rm \
    -v `pwd`/openapi-generator-fix-go:/root/src \
    -v `pwd`/5GC_APIs:/local \
    --name mvn-jdk \
    maven:3.6.3-jdk-11-openj9 /bin/bash

docker exec -it mvn-jdk /bin/bash
```

- 빌드 및 변환 작업

```sh
cd /root/src
mvn -am -pl "modules/openapi-generator-cli" package -DskipTests=true -Dmaven.javadoc.skip=true -Djacoco.skip=true

java -Dlog.level=info -jar /root/src/modules/openapi-generator-cli/target/openapi-generator-cli.jar generate -i /local/TS29122_NIDD.yaml -g go -o /local/out/fix-go
```

- inline_resolver 참고

```sh
git clone -b inline-resolver --single-branch https://github.com/fantavlik/openapi-generator openapi-generator-inline-resolver
```

- multipart/ mediatpe 참고

```sh
https://github.com/OpenAPITools/openapi-generator/pull/5613
https://github.com/zhemant/openapi-generator/tree/mpandencoding
```
