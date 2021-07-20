# 데이터 엔지니어링 초급 1일차
> 전체 과정에서 사용하는 기본적인 명령어 혹은 서비스 등에 대해 실습하고 사용법을 익힙니다

git, docker, linux CLI tools, hdfs, sql 


### 2. Git 명령어 실습

* Git ?
  - 분산 버전관리 시스템
  - 프로젝트에 형상관리 시스템
  - 리소스(코드, 파일, 메타데이터, 이미지  등)의 이력 및 변경관리
* [Git 용어](https://cupjoo.tistory.com/6)
  - Remote Repository (원격 저장소) : 원격 서버에서 관리되는 저장소, 다수의 사람이 공유 및 사용
  - Local Repository (로컬 저장소) : 개인 PC 내에 관리되는 저장소, PC 사용자가 관리하는 저장소
  - Index : 변경 사항이 로컬 저장소에 저장(Commit)되기 전에 임시로 기록되는 공간이며, 이 공간에 기록하는 행위를 Staging 이라고 합니다. 이 때에 저장을 원하지 않는 내역을 제외할 수도 있는데 이것을 Unstage 라고 합니다.
  - Commit : 프로젝트의 변경된 이력(Staged)을 로컬 저장소에 저장하는 행위를 말합니다.
  - Branch : 여러번의 Commmit 이 모여 하나의 큰 애플리케이션 구현 혹은 버그 수정 등의 작업 단위가 만들어지는데, 이러한 의도된 작업의 변경사항의 그룹을 Branch 라고 합니다.
  - Checkout : 여러개의 Commit 혹은 Branch 의 Commit 사이를 이동하는 행위를 말합니다
  - Merge : 변경 사항이 적용된 다른 Branch 를 현재 Branch 에 병합하는 행위를 말하며, 상충되는 코드나 메시지가 있는 경우 Conflict 가 나며, 이를 해결 후, Commit 되어야 합니다
  - Clone : 원격 저장소로부터 특정 프로젝트를 로컬 저장소에 다운로드 하는 행위를 말합니다
  - Pull : 원격 저장소로 부터 변경된 내역을 로컬 저장소에 반영하는 과정을 말합니다. 
  - Push : 로컬 저장소에 수정된 내역을 원격 저장소로 반영하는 과정을 말합니다.
* GitHub - [Git Cheat-sheet](https://education.github.com/git-cheat-sheet-education.pdf)

#### 2-1. 초기화
* init : 현재 디렉토리를 Git 레포지토리로 초기화 하고, 로컬 레포지토리로 관리됩니다
  - `.git` 경로가 생성되고, 하위에 index 및 object 들이 존재합니다
```bash
# git init
git init
```
* clone : 원격 저장소의 내용을 로컬 저장소에 다운로드 합니다
  - target directory 를 지정하지 않으면 프로젝트이름(`data-engineer-basic-training`)이 자동으로 생성됩니다
```bash
# git clone [uri]
git clone https://github.com/psyoblade/data-engineer-basic-training.git <target-directory>
```
<br>


#### 2-2. 스테이징
* status : 현재 경로의 스테이징 상태를 보여줍니다
```bash
# git status (-s, --short)
git status -s
```

* add : 저장 대상 파일(들)을 인덱스에 스테이징 합니다
  - 빈 디렉토리는 추가되지 않으며, 하나라도 파일이 존재해야 추가됩니다
  - 모든 Unstage 된 파일을 추가하는 옵션(-A)은 주의해서 사용해야 하며 .gitignore 파일을 잘 활용합니다
```bash
# git add (-A, --all) [file]
git add README.md
```

* reset : 스테이징 된 파일을 언스테이징 합니다
```bash
# git reset [file]
git reset README.md
```

* diff : 스테이징 된 파일에 따라 발생하는 이전 상태와 차이점을 보여줍니다
```bash
# git diff (--name-only)
git diff
```

* commit : 스테이징(add) 된 내역을 스냅샷으로 저장합니다
  - 스테이징 된 내역이 없다면 커밋되지 않습니다
```bash
# git commit -m "descriptive message"
git commit -m "[수정] 초기화 완료"
```

> 수정된 파일은 " M" 으로 표현되고, 스테이징된 파일은  "M " 으로 표현되며, 커밋된 파일은 status 에서 보이지 않습니다.

![git.1](images/git.1.png)

<br>


#### 2-3. 브랜치

* branch : 로컬(-r:리모트, -a:전체) 브랜치 목록을 출력, 생성, 삭제 작업을 수행합니다
```bash
# git branch (-r, --remotes | -a, --all)
git branch -a

# git branch [create-branch]
git branch lgde/2021

# git branch (-d, --delete) [delete-branch]
git branch -d lgde/2021
```

* checkout : 해당 브랜치로 이동합니다
  - 존재하는 브랜치로만 체크아웃이 됩니다 (-b 옵션을 주면 생성하면서 이동합니다)
```bash
# git checkout (-b) [branch-name]
git checkout -b lgde/2021
```

* merge : 대상 브랜치와 병합합니다. **대상 브랜치는 영향이 없고, 현재 브랜치가 변경**됩니다.
  - 변경하고자 하는 브랜치를 먼저 체크아웃하는 습관을 가지시면 좋습니다
```bash
# git merge [merge-branch]
git merge master
```

* log : 커밋 메시지를 브랜치 히스토리 별로 확인할 수 있습니다
```bash
git log
```
<br>


#### 2-4. 경로 관리

* rm : 커밋된 파일을 삭제합니다
```bash
# git rm [file]
git rm README.md
```

* mv : 파일 혹은 경로를 새로운 경로로 이동합니다
```bash
# git mv [source-path] [target-path]
git mv REAMDE.md tmp
```
<br>


#### 2-5. 예외 처리

> 깃으로 관리되지 않는 파일 혹은 경로를 패턴을 통해 관리합니다 - [gitignore.io](https://www.toptal.com/developers/gitignore)

* .gitignore : 해당 파일을 생성하고 내부 파일을 아래와 같이 관리합니다
```bash
# cat .gitignore
logs/
*.notes
tmp/
```
<br>


#### 2-6. 저장소 관리

> 원격 저장소와 동기화 하는 방법이며, pull, push 는 항상 conflict 에 유의해야 하며, 로컬 저장소에서 merge 및 conflict 해결하는 습관을 들여야만 합니다

* pull : 원격 저장소에서 변경된 내역을 로컬 저장소에 반영합니다
```bash
# git pull (--dry-run)
```

* push : 로컬 저장소의 커밋된 내역을 원격 저장소에 반영합니다
```bash
#
```

* :
```bash
#
```

* :
```bash
#
```

* :
```bash
#
```








- 목차
  * [0. SQL 기초 명령어](#0-SQL-기초-명령어)
  * [1. AWS 환경 구성](#1-AWS-및-로컬환경-구성)
  * [2. Git 명령어 실습](#2-Git-명령어-실습)
  * [3. Docker 명령어 실습](#3-Docker-명령어-실습)
  * [4. LGDE 서비스 시나리오](#4-LGDE-서비스-시나리오)


## 0. SQL 기초 명령어
* mysql 서버로 접속
```bash
bash> docker-compose exec mysql mysql -usqoop -psqoop

mysql> use testdb;
mysql> show tables;
```

* CREATE TABLE
```sql
CREATE TABLE table1 (
    col1 INT NOT NULL,
    col2 VARCHAR(10)
);

CREATE TABLE table2 (
    col1 INT NOT NULL AUTO_INCREMENT,
    col2 VARCHAR(10) NOT NULL,
    PRIMARY KEY (col1)
);
```

* SELECT
```sql
SELECT col1, col2
FROM table1;

SELECT col2
FROM table2
WHERE col1 = '찾는값'
```

* INSERT
```sql
INSERT INTO table1 ( col1 ) VALUES ( 1 );
INSERT INTO table2 VALUES ( 1, 'one' );
INSERT INTO table2 VALUES ( 2, 'two' ), ( 3, 'three' );
```

* UPDATE
```sql
UPDATE table1 SET col1 = 100 WHERE col1 = 1;
```

* DELETE
```sql
DELETE FROM table1 WHERE col1 = 100;
DELETE FROM table2;
```
## 1. AWS 및 로컬환경 구성

### 1.1 AWS 접속 및 포트 오픈 확인
> 각자 개인 계정으로 AWS 컨테이너에 접속이 가능한지, 기본 도구들이 설치되어 있는지 확인합니다
* AWS 인스턴스에 개인 계정으로 접속합니다
```bash
bash> ssh ubuntu@lgde # 개인별로 할당 받은 IP 혹은 DNS 로 접속하시면 됩니다
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

bash> sudo ./init.sh  # 명령을 통해 tree 패키지 및 rc 파일을 복사합니다
bash> d # alias 로 docker-compose 를 등록되어 --help 가 뜨면 정상입니다
bash> source ~/.bashrc  # d 명령어 오류가 나는 경우 .bashrc 를 다시 로딩합니다
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
bash> tree

bash> git clean -d -n  # 명령으로 삭제될 대상 디렉토리/파일을 확인하고
bash> git clean -d -f  # 명령으로 삭제합니다
bash> git status -sb
bash> tree
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

### 2.6 깃 패스워드를 캐시
```bash
bash> git config --global credential.helper cache
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
$> fortune
$> exit  # 명령어 실행에 성공했다면, Ctrl+D 혹은 exit 명령어로 빠져나옵니다

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
  - 도커 이미지 다운로드 시간이 약 2~3분 소요됩니다
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

$> # parquet 파일을 확인합니다
$> hadoop jar /jdbc/parquet-tools-1.8.1.jar schema file://<target-parquet-file>
$> exit

bash> tree notebooks
```

### 4.3 고객 접속 정보(access)를 오픈소스 Fluentd 를 통해 수집합니다 (fluentd)
* exec 명령을 통해서 fluentd 가 설치된 우분투 서버에 접속합니다
* #1. 사전에 작성된 /tmp/source/access.csv 파일이 생성되면 tailing 하면서 수집하는 fluent.tail 파일을 이용하여 수집서버를 기동시킵니다
```bash
bash> docker-compose exec fluentd bash

$> more /etc/fluentd/fluent.tail
$> rm -rf /tmp/source/access.*
$> ./fluentd.sh -c /etc/fluentd/fluent.tail
```

* 정상적으로 fluentd 서버가 기동된 것을 확인하고 별도의 창을 하나 더 띄워서 /etc/fluentd/access.csv 파일을 복사합니다
  - 별도의 탭을 이용하여 서버에 접속하여, 테스트 과정에 발생할 수 있는 임시파일을 삭제합니다
```bash
bash> cd ~/workspace/data-engineer-basic-training/day1/
bash> docker-compose exec fluentd bash

$> head /etc/fluentd/access.csv

$> touch /tmp/source/access.csv  # 명령 이후에 #1 터미널에서 파일을 인지한 것을 확인합니다
$> cat /etc/fluentd/access.csv >> /tmp/source/access.csv 
$> ls -al /tmp/target/access/20201025/*.json

$> exit
```
* 첫 번째로 띄웠던 터미널도 접속 종료합니다
```bash
#1> exit  # Ctrl+C 를 통해 fluentd.sh 종료 후 터미널을 종료합니다

bash> ls -al ~/workspace/data-engineer-basic-training/day1/notebooks  # 수집된 3개의 테이블이 존재하는지 확인합니다
bash> tree ~/workspace/data-engineer-basic-training/day1/notebooks
```


### 4.4 수집된 고객, 매출 및 접속 정보를 오픈소스 Spark 를 통해 탐색합니다 (spark+notebook)
* 노트북 접속을 위한 URL을 확인하여, http://127.0.0.1:8888 로 시작하는 URL을 아래와 같이 변경하여 접속합니다
  - [1일차 - LGDE.com 인터넷 쇼핑몰 지표 설계 및 개발](http://htmlpreview.github.io/?https://github.com/psyoblade/data-engineer-basic-training/blob/master/day1/notebooks/html/lgde-basic-day1.html)
  - AS-IS: http://127.0.0.1:8888/?token=270cc209f2aeba4d95f91c3d22b78acacf3428e06bd2cff6
  - TO-BE: http://{ec2-instance-ip}:8888/?token={notebook-token-copied}
* 테이블 수집 및 변환작업이 완료되었다면, 하이브 작업을 위해 기존의 모든 프로세스는 종료합니다
  - 하이브의 경우 의존성이 있는 컴포넌트가 많아서 별도의 컨테이너에서 띄우는 것이 좋습니다
```bash
bash> docker-compose logs notebook | grep localhost
or http://127.0.0.1:8888/?token=270cc209f2aeba4d95f91c3d22b78acacf3428e06bd2cff6
```


### 4.5 원본 로그를 통해 추출 가능한 기본 지표를 추출합니다 (spark+notebook)
> 크롬을 통해서 http://{ec2-instance-ip}:8888/?token={notebook-token-copied} 사이트에 접속합니다
  

### 4.6 추출된 기본지표를 하이브 테이블로 작성하고 제공합니다 (hive)
* 테이블을 생성한 이후에 로컬 파일을 로딩하여 생성하는 방법이 가장 간편합니다
```bash
bash> docker-compose exec hive-server bash
bash> beeline

beeline> 
!connect jdbc:hive2://localhost:10000 scott tiger

beeline> 
create database if not exists testdb comment 'test database' location '/user/hive/warehouse/testdb' with dbproperties ('createdBy' = 'psyoblade');
use testdb;
drop table if exists local_users;

create table if not exists local_users 
(a_uid string, a_count bigint, p_amount bigint, p_count bigint, u_name string, u_gender string, u_signup string)
partitioned by (dt int)
row format delimited
stored as parquet;

load data local inpath '/tmp/target/dim_users/dt=20201025' overwrite into table local_users partition (dt = 20201025);
select dt, u_gender, count(1) from local_users group by dt, u_gender;
```
* 대상 테이블을 분산 저장소에 저장하여 하이브 테이블을 생성할 수도 있습니다
  - 스파크를 통해 생성된 파일을 하둡 클러스터에 업로드합니다 (기존에는 로컬에 저장했습니다)
```bash
bash> docker-compose exec hive-server bash

bash> hadoop fs -mkdir -p /user/lgde/dim_users
bash> hadoop fs -put /tmp/target/dim_users/* /user/lgde/dim_users 
bash> hadoop fs -ls /user/lgde/dim_users

bash> beeline
beeline> !connect jdbc:hive2://localhost:10000 scott tiger

beeline> 
create database if not exists testdb comment 'test database' location '/user/hive/warehouse/testdb' with dbproperties ('createdBy' = 'psyoblade');
use testdb;
drop table if exists dim_users;

create table if not exists dim_users 
(a_uid string, a_count bigint, p_amount bigint, p_count bigint, u_name string, u_gender string, u_signup string)
partitioned by (dt int)
row format delimited
stored as parquet
location 'hdfs://namenode:8020/user/lgde/dim_users';

alter table dim_users add if not exists partition (dt = 20201025);
describe extended dim_users partition (dt = '20201025');
select dt, u_gender, count(1) from dim_users group by dt, u_gender;
```

