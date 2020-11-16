# 데이터 엔지니어링 초급 1일차
> AWS 환경 구성, Git 및 Docker 명령어 실습을 통해 기본적인 도구를 손에 익힙니다.
> 가상의 인터넷 쇼핑몰 "LGDE" 사이트에서 발생하는 다양한 로그를 통해 고객을 분석하고, 의사결정을 위한 지표를 생성하는 시나리오를 경험합니다

- 목차
  * [1. AWS 환경 구성](#1-AWS-및-로컬환경-구성)
  * [2. Git 명령어 실습](#2-Git-명령어-실습)
  * [3. Docker 명령어 실습](#3-Docker-명령어-실습)
  * [4. LGDE 서비스 시나리오](#4-LGDE-서비스-시나리오)

## 1. AWS 및 로컬환경 구성

### 1.1 AWS 접속 및 포트 오픈 확인
> 각자 개인 계정으로 AWS 컨테이너에 접속이 가능한지, 기본 도구들이 설치되어 있는지 확인합니다
* AWS 인스턴스에 개인 계정으로 접속합니다
```bash
```

* 서버에 접속하여 기본 도구들이 설치되어 있는지 버전은 맞는지 확인합니다
```bash
bash> docker --version
Docker version 19.03.13, build 4484c46d9d

bash> docker-compose version
docker-compose version 1.27.4, build 40524192
```


## 2. Git 명령어 실습
> 이번 강좌에서 사용하게 될 주요 Git 명령어에 대해 실습합니다 

### 2.1 헬로월드 레포지토리를 복제합니다
* [psyoblade/hellowolrld](https://github.com/psyoblade/helloworld) 사이트에 접속하여 Code 버튼을 클릭하고 주소를 복사합니다
![LGDE1.1](images/lgde.1.1.png)
```bash
bash> mkdir -p ~/workspace
bash> cd ~/workspace

bash> git clone https://github.com/psyoblade/helloworld.git
bash> cd helloworld

bash> ./init.sh  # 명령을 통해 tree 패키지 및 rc 파일을 복사합니다
```

### 2.2 helloworld.py 파일을 수정하고, 원래 파일의 상태로 되돌립니다
```bash
bash> echo "print('helloworld')" >> helloworld.py
bash> python3 helloworld.py

bash> git status -sb
bash> git diff

bash> git checkout -- .
bash> python3 helloworld.py
```

### 2.3 임의의 파일을 추가하고 스테이징 상태까지 갔다가 다시 원래 상태로 되돌립니다
```bash
bash> touch XXX
bash> git add XXX  # 지정한 하나의 파일만 스테이징 합니다
bash> git status -sb

bash> git reset -- .
bash> git status -sb
bash> rm XXX
```

### 2.4 임의의 가비지 파일을 10개 생성하고, 깃 클린 명령어를 통해 정리합니다
```bash
bash> mkdir -p tmp
bash> for x in $(seq 1 10); do touch tmp/XXX_$x; done

bash> git clean -d -n  # 명령으로 삭제될 대상 디렉토리/파일을 확인하고
bash> git clean -d -f  # 명령으로 삭제합니다
bash> git status -sb
```

### 2.5 컨테이너 시작, 종료가 정상적으로 되지 않는 경우
> 이미 기동되어 있는 컨테이너와 이름이 동일하거나, 컨테이너에 오류가 있어 기동되지 않은 경우에도 컨테이너 정보는 여전히 남아있어 다음 실행 시에 문제가 될 수 있습니다.
* 모든 도커 컨테이너를 확인 및 삭제하는 명령어
```bash
bash> docker ps      # Running 중인 모든 컨테이너를 확인합니다
bash> docker ps -a   # 모든 컨테이너를 확인합니다
bash> docker ps -aq  # 모든 컨테이너의 ID 값만 출력합니다

bash> docker rm -f `docker ps -aq`  # 로컬에 존재하는 모든 컨테이너를 강제로 종료합니다
bash> docker container prune  # 사용되지 않는 모든 가비지 컨테이너를 정리합니다
bash> docker network prune  # 사용되지 않는 모든 네트워크를 정리합니다
```


## 3. Docker 명령어 실습

### 3.1 예제 코드를 다운로드 받습니다

* [docker-compose](https://github.com/psyoblade/docker-compose-for-dummies.git) 로부터 코드를 다운로드 받습니다
```bash
bash> cd ~/workspace
bash> git clone https://github.com/psyoblade/docker-compose-for-dummies.git
```

### 3.2 Ubuntu 컨테이너를 기동하고 fortune 명령어를 실행합니다
```bash
bash> cd ~/workspace/docker-compose-for-dummies/ubuntu
bash> docker-compose up -d
bash> docker-compose ps ubuntu # ubuntu /bin/bash 가 기동 되었는지 확인합니다

bash> docker-compose exec ubuntu bash  # 우분투 컨테이너로 접속합니다
$> fortune  # 명령어 실행에 성공했다면, Ctrl+D 로 빠져나옵니다

bash> docker-compose down  # 컨테이너를 종료합니다
```

### 3.3 MySQL + phpMyAdmin 서비스를 기동하고 테스트 합니다
```bash
bash> cd ~/workspace/docker-compose-for-dummies/mysql
bash> docker-compose up -d
bash> docker-compose ps  # mysql 과 phpmyadmin 이 기동 되었음을 확인합니다
bash> docker-compose top  # 서비스명을 입력하지 않으면 2개 서비스의 프로세스를 모두 확인합니다
```

### 3.4 phpMyAdmin 웹 페이지에 접속합니다
* 로그인 전후에 로그가 정상적으로 출력됨을 확인할 수 있습니다
```bash
bash> docker-compose logs -f phpmyadmin  # 서비스 로그를 확인할 수 있도록 로그를 모니터링 합니다
bash> # 브라우저를 통해서 http://<aws-ec2-instance-url-or-ip>:8183 으로 접속하여 user / user 로 로그인합니다
bash> docker-compose down  # 모든 서비스 컨테이너를 종료합니다
```


## 4. LGDE 서비스 시나리오
> 가상의 인터넷 쇼핑몰 "LGDE.com" 지표 개발 시나리오

### 4.1 데이터 수집을 위한 예제 프로젝트를 다운로드 합니다 (git)
* 모든 서비스(mysql, sqoop, fluentd, notebook)가 전부 기동되었는지 확인합니다
```bash
bash> cd ~/workspace
bash> git clone https://github.com/psyoblade/data-engineer-basic-training.git 
bash> cd ~/workspace/data-engineer-basic-training/day1

bash> docker-compose up -d
bash> docker-compose ps --services
```

### 4.2 고객 정보(user) 및 매출 정보(purchase) 테이블을 오픈소스 Sqoop 을 통해 수집합니다 (sqoop)
* exec 명령을 통해서 sqoop 이 설치된 우분투 서버에 접속합니다
* 터미널 종료 시에는 exit 혹은 Ctrl+D 로 빠져나옵니다
```bash
bash> docker-compose exec sqoop bash
$> sqoop list-databases --connect jdbc:mysql://mysql:3306 --username sqoop --password sqoop
$> sqoop list-tables --connect jdbc:mysql://mysql:3306/testdb --username sqoop --password sqoop

$> sqoop eval --connect jdbc:mysql://mysql:3306/testdb --username sqoop --password sqoop -e "describe user"
$> sqoop eval --connect jdbc:mysql://mysql:3306/testdb --username sqoop --password sqoop -e "select * from user"
$> sqoop eval --connect jdbc:mysql://mysql:3306/testdb --username sqoop --password sqoop -e "select * from purchase"

$> sqoop import -jt local -m 1 --connect jdbc:mysql://mysql:3306/testdb --table user \
    --target-dir file:///tmp/target/user/20201025 --username sqoop --password sqoop \
    --relaxed-isolation --as-parquetfile --delete-target-dir
$> sqoop import -jt local -m 1 --connect jdbc:mysql://mysql:3306/testdb --table purchase \
    --target-dir file:///tmp/target/purchase/20201025 --username sqoop --password sqoop \
    --relaxed-isolation --as-parquetfile --delete-target-dir

$> ls /tmp/target/*/20201025/*.parquet
$> exit
```

### 4.3 고객 접속 정보(access)를 오픈소스 Fluentd 를 통해 수집합니다 (fluentd)
* exec 명령을 통해서 fluentd 가 설치된 우분투 서버에 접속합니다
* #1. 사전에 작성된 /tmp/source/access.csv 파일이 생성되면 tailing 하면서 수집하는 fluent.tail 파일을 이용하여 수집서버를 기동시킵니다
```bash
bash> docker-compose exec fluentd bash

$> more /etc/fluentd/fluent.tail
$> ./fluentd.sh -c /etc/fluentd/fluent.tail
```

* 정상적으로 fluentd 서버가 기동된 것을 확인하고 별도의 창을 하나 더 띄워서 /etc/fluentd/access.csv 파일을 복사합니다
  - 별도의 탭을 이용하여 서버에 접속하여, 테스트 과정에 발생할 수 있는 임시파일을 삭제합니다
```bash
$> rm -rf /tmp/source/access.pos
$> head /etc/fluentd/access.csv

$> touch /tmp/source/access.csv  # 명령 이후에 #1 터미널에서 파일을 인지한 것을 확인합니다
$> cat /etc/fluentd/access.csv > /tmp/source/access.csv 
$> ls -al /tmp/target/access/20201025/*.json

$> exit
```
* 첫 번째로 띄웠던 터미널도 접속 종료합니다
```bash
$1> exit  # Ctrl+C 를 통해 fluentd.sh 종료 후 터미널을 종료합니다

bash> ls -al ~/workspace/data-engineer-basic/day1/notebooks  # 수집된 3개의 테이블이 존재하는지 확인합니다
```


### 4.4 수집된 고객, 매출 및 접속 정보를 오픈소스 Spark 를 통해 탐색합니다 (spark+notebook)
* 노트북 접속을 위한 URL을 확인하여, http://127.0.0.1:8888 로 시작하는 URL로 접속합니다
  - [1일차 - LGDE.com 인터넷 쇼핑몰 지표 설계 및 개발](http://htmlpreview.github.io/?https://github.com/psyoblade/data-engineer-basic-training/blob/main/day1/notebooks/html/lgde-basic-day1.html)
* 테이블 수집 및 변환작업이 완료되었다면, 하이브 작업을 위해 기존의 모든 프로세스는 종료합니다
  - 하이브의 경우 의존성이 있는 컴포넌트가 많아서 별도의 컨테이너에서 띄우는 것이 좋습니다
```bash
bash> docker-compose logs notebook

bash> docker-compose down
```


### 4.5 원본 로그를 통해 추출 가능한 기본 지표를 추출합니다 (spark+notebook)
```bash
bash>
```


### 4.6 추출된 기본지표를 하이브 테이블로 작성하고 제공합니다 (hive)
* 테이블을 생성한 이후에 로컬 파일을 로딩하여 생성하는 방법이 가장 간편합니다
```bash
bash> docker-compose exec hive-server bash
bash> beeline
beeline> !connect jdbc:hive2://localhost:10000 scott tiger

beeline> create table if not exists local_users (d_uid string, d_name string, d_gender string, d_account bigint, d_pamount bigint, d_pcount bigint)
    partitioned by (dt int)
    row format delimited
    fields terminated by ','
    stored as parquet;

beeline> load data local inpath '/tmp/target/dim_users/dt=20201025' overwrite into table local_users partition (dt = 20201025);
beeline> load data local inpath '/tmp/target/dim_users/dt=20201025' overwrite into table local_users partition (dt = 20201026);
beeline> select dt, d_gender, count(1) from local_users group by dt, d_gender;
```
* 대상 테이블을 분산 저장소에 저장하여 하이브 테이블을 생성할 수도 있습니다
  - 스파크를 통해 생성된 파일을 하둡 클러스터에 업로드합니다 (기존에는 로컬에 저장했습니다)
```bash
bash> docker-compose exec hive-server bash

bash> hadoop fs -mkdir /user/lgde/dim_users
bash> hadoop fs -put /tmp/target/dim_users/* /user/lgde/dim_users 
bash> hadoop fs -ls /user/lgde/dim_users

bash> beeline
beeline> !connect jdbc:hive2://localhost:10000 scott tiger

beeline> create database if not exists testdb comment 'test database' location '/user/hive/warehouse/testdb' with dbproperties ('createdBy' = 'psyoblade');
beeline> drop table if exists dim_users;
beeline> create external table if not exists dim_users (d_uid string, d_name string, d_gender string, d_account bigint, d_pamount bigint, d_pcount bigint)
    comment 'users dimension'
    partitioned by (dt int)
    row format delimited
    fields terminated by ','
    stored as parquet
    location 'hdfs://namenode:8020/tmp/target/dim_users';

beeline> alter table dim_users add if not exists partition (dt = 20201025);
beeline> alter table dim_users add if not exists partition (dt = 20201026);
beeline> describe extended dim_users partition (dt = '20201025');
beeline> select dt, d_gender, count(1) from dim_users group by dt, d_gender;
```

