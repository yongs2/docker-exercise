# centos7 빌드용 docker image 생성

## 1. docker images 생성

- centos 7.1.1503 에서만 빌드해야 하는 소스가 있어서 생성
- 생성 중  다음과 같이 오류 발생

```sh
...
--> Finished Dependency Resolution
Error: libselinux conflicts with fakesystemd-1-17.el7.centos.noarch
 You could try using --skip-broken to work around the problem
...
```

- 이에 대해 구글링 결과 다음의 해결책을 찾음 : [Fixing CentOS 7 systemd conflicts with docker](https://blog.centos.org/2015/12/fixing-centos-7-systemd-conflicts-with-docker/)

- 프로젝트 소스를 빌드하기 위해서는 다음 패키지들이 추가적으로 필요

```sh
yum install -y openssl-devel net-snmp-devel libaio

echo "https://qiita.com/tkprof/items/2a4eb868f45fb5759110"
cd /etc/yum.repos.d;
curl -O http://yum.oracle.com/public-yum-ol7.repo;
curl -O http://yum.oracle.com/RPM-GPG-KEY-oracle-ol7;
rpm --import RPM-GPG-KEY-oracle-ol7;
yum install -y yum-utils;
yum-config-manager --enable ol7_oracle_instantclient;

yum install -y oracle-instantclient19.3-basic
yum install -y oracle-instantclient19.3-devel
yum install -y oracle-instantclient19.3-odbc

echo /usr/lib/oracle/19.3/client64/lib > /etc/ld.so.conf.d/oracle-instantclient.conf
export LD_LIBRARY_PATH=/usr/lib/oracle/19.3/client64/lib:$LD_LIBRARY_PATH

rpm -qa | grep inst
rpm -ql oracle-instantclient19.3-basic-19.3.0.0.0-1.x86_64
rpm -ql oracle-instantclient19.3-devel-19.3.0.0.0-1.x86_64
rpm -ql oracle-instantclient19.3-odbc-19.3.0.0.0-1.x86_64

find trunk/ -name "Makefile" -exec grep 'ORACLE_HOME) ' {} \;
find trunk/ -name "Makefile" -exec grep 'ORACLE_HOME)/inc/ ' {} \;
find trunk/ -name "Makefile" -exec grep 'lnnz12 -lons ' {} \;
find trunk/ -name "Makefile" -exec sed -i 's/-I$(ORACLE_HOME) /-I\/usr\/include\/oracle\/19.3\/client64 /g' {} \;
find trunk/ -name "Makefile" -exec sed -i 's/-I$(ORACLE_HOME)\/inc\/ /-I\/usr\/include\/oracle\/19.3\/client64 /g' {} \;
find trunk/ -name "Makefile" -exec sed -i 's/-lnnz12 -lons/-lnnz19/g' {} \;

export ORACLE_HOME="/usr/lib/oracle/19.3/client64/"
export G_PROJ_LIB="-L${HOME}/trunk/lib -L/usr/local/lib64 -L/usr/lib/oracle/19.3/client64/lib/"
export G_PROJ_INC="-I/usr/include -I/usr/include/oracle/19.3/client64/"
export G_SYSTEM_DEFINE="-m64 -I/usr/include/oracle/19.3/client64/"
export G_PROJ_DEFINE="-I/usr/include -I${HOME}/trunk/inc/"

cd trunk;
rm -Rf src/lib/oam/src/cpm_db;
rm -Rf src/lib/oam/src/libAlti;
make -f build/Makefile
```

- 프로젝트를 빌드하기 위한 pipeline script 작성

```groovy
podTemplate(
    containers: [
        containerTemplate(name: 'builder', image: '192.168.0.210:5000/centos7-svn:1.0.0', ttyEnabled: true, command: 'cat'),
        , containerTemplate(name: 'docker', image: 'docker.io/docker:19.03.1', ttyEnabled: true, command: 'cat')
    ],
    volumes: [
        hostPathVolume(hostPath: '/var/run/docker.sock', mountPath: '/var/run/docker.sock')
    ]
)
{
    node(POD_LABEL) {
        def DOCKER_REGISTRY = '192.168.0.210:5000'

        stage('svn checkout') {
            try {
                checkout([$class: 'SubversionSCM'
                    , additionalCredentials: []
                    , excludedCommitMessages: ''
                    , excludedRegions: ''
                    , excludedRevprop: ''
                    , excludedUsers: ''
                    , filterChangelog: false
                    , ignoreDirPropChanges: false
                    , includedRegions: ''
                    , locations: [[cancelProcessOnExternalsFail: true
                        , credentialsId: 'svn_budilbot'
                        , depthOption: 'infinity'
                        , ignoreExternalsOption: false
                        , local: '.'
                        , remote: '${SVN_URL}']
                    ]
                    , quietOperation: true
                    , workspaceUpdater: [$class: 'CheckoutUpdater']
                ])
            }
            catch(err) {
                println 'svn checkout failed: ${err}'
            }
        }

        container('builder') {
            stage('Prepare build environment') {
                sh 'yum install -y openssl-devel net-snmp-devel libaio;'
            }
            stage('Prepare oracle instantclient') {
                sh '''cd /etc/yum.repos.d; \
                    curl -O http://yum.oracle.com/public-yum-ol7.repo; \
                    curl -O http://yum.oracle.com/RPM-GPG-KEY-oracle-ol7; \
                    rpm --import RPM-GPG-KEY-oracle-ol7; \
                    yum install -y yum-utils; \
                    yum-config-manager --enable ol7_oracle_instantclient; \
                    yum install -y oracle-instantclient19.3-basic; \
                    yum install -y oracle-instantclient19.3-devel; \
                    yum install -y oracle-instantclient19.3-odbc; \
                    echo /usr/lib/oracle/19.3/client64/lib > /etc/ld.so.conf.d/oracle-instantclient.conf; \
                    export LD_LIBRARY_PATH=/usr/lib/oracle/19.3/client64/lib:$LD_LIBRARY_PATH; \
                '''
            }
            stage('Modified Makefile') {
                script {
                    sh 'cd ${HOME}; '
                    sh 'pwd'
                    sh(script: 'find ${PWD}/ -name "Makefile" -exec grep "\\$(ORACLE_HOME) " {} \\; ', returnStdout: true)
                    sh(script: 'find ${PWD}/ -name "Makefile" -exec grep "lnnz12 -lons " {} \\; ', returnStdout: true)
                    sh(script: 'find ${PWD}/ -name "Makefile" -exec sed -i "s/\\-I\\$(ORACLE_HOME) /\\-I\\/usr\\/include\\/oracle\\/19.3\\/client64 /g" {} \\; ', returnStdout: true)
                    sh(script: 'find ${PWD}/ -name "Makefile" -exec sed -i "s/\\-I\\$(ORACLE_HOME)\\/inc\\/ /\\-I\\/usr\\/include\\/oracle\\/19.3\\/client64 /g" {} \\; ', returnStdout: true)
                    sh(script: 'find ${PWD}/ -name "Makefile" -exec sed -i "s/\\-I\\$(ORACLE_HOME)\\/precomp\\/public\\//\\-I\\/usr\\/include\\/oracle\\/19.3\\/client64 /g" {} \\; ', returnStdout: true)
                    sh(script: 'find ${PWD}/ -name "Makefile" -exec sed -i "s/-lnnz12 -lons/-lnnz19/g" {} \\; ', returnStdout: true)
                }
            }
            stage('Build a project') {
                sh '''pwd; \
                    export WORKHOME=${PWD}; \
                    export ORACLE_HOME="/usr/lib/oracle/19.3/client64/"; \
                    export G_PROJ_LIB="-L${WORKHOME}/lib -L/usr/local/lib64 -L/usr/lib/oracle/19.3/client64/lib/"; \
                    export G_PROJ_INC="-I/usr/include -I/usr/include/oracle/19.3/client64/"; \
                    export G_SYSTEM_DEFINE="-m64 -I/usr/include/oracle/19.3/client64/"; \
                    export G_PROJ_DEFINE="-I/usr/include -I${WORKHOME}/inc/"; \
                    LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${WORKHOME}/lib:/usr/local/lib/; export LD_LIBRARY_PATH; \
                    rm -Rf src/lib/oam/src/cpm_db; \
                    rm -Rf src/lib/oam/src/libAlti; \
                    make -f build/Makefile; \
                '''
            }
        }
    }
}
```
