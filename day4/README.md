# 4일차. 데이터 엔지니어링 적재

> 아파치 하이브를 통해 다양한 데이터 웨어하우스 예제를 실습합니다

* 목차
  * [1. 최신버전 업데이트](#1-최신버전-업데이트)
  * [2. 하이브 기본명령어 가이드](#2-하이브-기본-명령어-가이드)
    * [2-1. 하이브 데이터베이스 DDL 가이드](#2-1-하이브-데이터베이스-DDL-가이드)
    * [2-2. 하이브 테이블 DDL 가이드](#2-2-하이브-테이블-DDL-가이드)
    * [2-3. 하이브 DML 가이드](#2-3-하이브-DML-가이드)
    * [2-4. 하이브 외부 저장소 테이블](#2-4-하이브-외부-저장소-테이블)
  * [3. 참고 자료](#참고-자료)

<br>


## 1. 최신버전 업데이트
> 원격 터미널에 접속하여 관련 코드를 최신 버전으로 내려받고, 과거에 실행된 컨테이너가 없는지 확인하고 종료합니다

### 1-1. 최신 소스를 내려 받습니다
```bash
# terminal
cd /home/ubuntu/work/data-engineer-basic-training
git pull
```
<br>

### 1-2. 현재 기동되어 있는 도커 컨테이너를 확인하고, 종료합니다

#### 1-2-1. 현재 기동된 컨테이너를 확인합니다
```bash
# terminal
docker ps -a
```
<br>


#### 1-2-2. 기동된 컨테이너가 있다면 강제 종료합니다
```bash
# terminal 
docker rm -f `docker ps -aq`
```
> 다시 `docker ps -a` 명령으로 결과가 없다면 모든 컨테이너가 종료되었다고 보시면 됩니다
<br>


#### 1-2-3. 하이브 실습을 위한 컨테이너를 기동합니다
```bash
# terminal
cd /home/ubuntu/work/data-engineer-basic-training/day8
docker compose pull
docker compose up -d
docker compose ps
```
<br>


#### 1-2-4. 실습에 필요한 IMDB 데이터를 컨테이너로 복사합니다
```bash
# terminal
docker compose cp data/imdb.tsv hive:/opt/hive/examples/imdb.tsv
docker compose exec hive-serverls /opt/hive/examples
```

> 마지막 ls /opt/hive/examples 명령어 결과로 imdb.tsv 파일이 확인되면 정상입니다
<br>


#### 1-2-5. 하이브 컨테이너로 접속합니다
```bash
# terminal
docker compose exec hive-serverbash
```
<br>


#### 1-2-6. beeline 프로그램을 통해 hive 서버로 접속합니다

> 여기서 `beeline` 은 Hive (벌집)에 접속하여 SQL 명령을 수행하기 위한 커맨드라인 프로그램이며, Oracle 의 SQL\*Plus 와 같은 도구라고 보시면 됩니다

* 도커 컨테이너에서 beeline 명령을 수행하면 프롬프트가 `beeline>` 으로 변경되고, SQL 명령의 수행이 가능합니다
```bash
# docker
beeline
```
<br>


* beeline 프롬프트가 뜨면 Hive Server 에 접속하기 위해 대상 서버로 connect 명령을 수행합니다
```bash
# beeline
!connect jdbc:hive2://localhost:10000 scott tiger
```
> 아래와 같은 메시지가 뜨면 성공입니다

```bash
Connecting to jdbc:hive2://localhost:10000
Connected to: Apache Hive (version 2.3.2)
Driver: Hive JDBC (version 2.3.2)
Transaction isolation: TRANSACTION_REPEATABLE_READ
```

[목차로 돌아가기](#4일차-아파치-하이브-데이터-적재)

<br>
<br>



## 2 하이브 기본 명령어 가이드 

### 2-1 하이브 데이터베이스 DDL 가이드

#### 2-1-1. 데이터베이스 생성 - CREATE

```sql
/** Usages
    CREATE (DATABASE|SCHEMA) [IF NOT EXISTS] database_name
        [COMMENT database_comment]
        [LOCATION hdfs_path]
        [WITH DBPROPERTIES (property_name=property_value, ...)]; 
*/
```
* 테스트 데이터베이스 testdb 를 생성합니다
```sql
# beeline>
create database if not exists testdb comment 'test database'
location '/user/hive/warehouse/testdb' with dbproperties ('createdBy' = 'psyoblade');
```
<br>


#### 2-1-2. 데이터베이스 목록 출력 - SHOW

```sql
/** Usages
    SHOW (DATABASES|SCHEMAS);
*/
```

* 데이터베이스 목록 전체를 출력합니다
```sql
# beeline> 
show databases;
```
<br>


#### 2-1-3. 데이터베이스 정보를 출력합니다 - DESCRIBE

```sql
/** Usages
    DESCRIBE DATABASE/SCHEMA [EXTENDED] db_name;
*/
```
* 데이터베이스 생성 정보를 출력합니다
  - EXTENDED 키워드는 보다 상세한 정보를 출력합니다
```sql
# beeline> 
describe database testdb;
```
<br>


#### 2-1-4. 지정한 데이터베이스를 사용합니다 - USE
```sql
/** Usages
    USE database_name;
*/
```
* 위에서 생성한 testdb 를 현재 세션에서 사용하도록 선언합니다
```sql
# beeline> 
use testdb;
```
<br>


#### 2-1-5. 데이터베이스를 삭제합니다 - DROP
```sql
/** Usages
    DROP (DATABASE|SCHEMA) [IF EXISTS] database_name [RESTRICT|CASCADE];
*/
```
* 지정한 데이터베이스를 삭제하며, 테이블이 존재하는 경우 오류가 발생합니다 (default:RESTRICT)
  - CACADE 옵션을 주는 경우 포함하고 있는 모든 테이블까지 삭제됩니다
```sql
# beeline> 
drop database testdb;
show databases;
```
<br>


#### 2-1-6. 데이터베이스의 정보를 변경합니다 - ALTER
> 데이터베이스에는 크게 DBPROPERTIES 와 OWNER 속성 2가지를 가지고 있습니다

##### DBPROPERTIES 속성
* `키=값` 쌍으로 다양한 용도로 사용되는 값을 넣는 Map 같은 메타데이터 정보입니다
```sql
/** Usages
    ALTER (DATABASE|SCHEMA) database_name SET DBPROPERTIES (property_name=property_value, ...);
*/
```
* 데이터베이스 생성자 혹은 필요에 따라 원하는 메타데이터 정보를 데이터베이스 생성 시에 추가할 수 있습니다
```sql
# beeline> 
create database if not exists testdb comment 'test database' 
location '/user/hive/warehouse/testdb' with dbproperties ('createdBy' = 'psyoblade');
```
<br>

* 이미 생성된 데이터베이스는 ALTER 명령어로 수정이 가능합니다
```sql
alter database testdb set dbproperties ('createdfor'='park.suhyuk');
```
* 수정된 DBPROPERTIES 정보를 확인합니다
```sql
describe database extended testdb;
```
<br>


##### OWNER 속성
* 데이터베이스 관리를 어떤 기준(User or Role)으로 할 지를 결정합니다 
```sql
/** Usages
    ALTER (DATABASE|SCHEMA) database_name SET OWNER [USER|ROLE] user_or_role;
*/
```
* 테스트 데이터베이스 `testdb` 에 대해 `admin` 이라는 `role` 기반으로 관리하도록 설정합니다
  - 계정 단위로 관리하는 것은 번거롭고 관리 비용이 커질 수 있습니다
```sql
# beeline> 
alter database testdb set owner role admin;
```
<br>

* 수정된 OWNER 정보를 확인합니다 
```sql
describe database extended testdb;
```

[목차로 돌아가기](#4일차-아파치-하이브-데이터-적재)

<br>
<br>


### 2-2 하이브 테이블 DDL 가이드

#### 2-2-1. 테이블 생성 - CREATE

> 테이블 생성 구문에 대부분의 중요한 키워드가 포함되어 있으므로 잘 이해하고 넘어가시길 바랍니다

```sql
/** Usages
    CREATE TABLE [IF NOT EXISTS] [db_name.] table_name [(col_name data_type [COMMENT col_comment], ...)]
        [COMMENT table_comment]
        [ROW FORMAT row_format]
        [STORED AS file_format]
        [LOCATION hdfs_path];

    data_type
      : primitive_type
      | array_type
      | map_type
      | struct_type
      | union_type  -- (Note: Available in Hive 0.7.0 and later)
     
    primitive_type
      : TINYINT
      | SMALLINT
      | INT
      | BIGINT
      | BOOLEAN
      | FLOAT
      | DOUBLE
      | DOUBLE PRECISION -- (Note: Available in Hive 2.2.0 and later)
      | STRING
      | BINARY      -- (Note: Available in Hive 0.8.0 and later)
      | TIMESTAMP   -- (Note: Available in Hive 0.8.0 and later)
      | DECIMAL     -- (Note: Available in Hive 0.11.0 and later)
      | DECIMAL(precision, scale)  -- (Note: Available in Hive 0.13.0 and later)
      | DATE        -- (Note: Available in Hive 0.12.0 and later)
      | VARCHAR     -- (Note: Available in Hive 0.12.0 and later)
      | CHAR        -- (Note: Available in Hive 0.13.0 and later)

    array_type
      : ARRAY < data_type >
     
    map_type
      : MAP < primitive_type, data_type >
     
    struct_type
      : STRUCT < col_name : data_type [COMMENT col_comment], ...>
     
    union_type
       : UNIONTYPE < data_type, data_type, ... >  -- (Note: Available in Hive 0.7.0 and later)

    row_format
      : DELIMITED [FIELDS TERMINATED BY char [ESCAPED BY char]] [COLLECTION ITEMS TERMINATED BY char]
            [MAP KEYS TERMINATED BY char] [LINES TERMINATED BY char]
            [NULL DEFINED AS char]   -- (Note: Available in Hive 0.13 and later)
      | SERDE serde_name [WITH SERDEPROPERTIES (property_name=property_value, property_name=property_value, ...)]

    file_format:
      : SEQUENCEFILE
      | TEXTFILE    -- (Default, depending on hive.default.fileformat configuration)
      | RCFILE      -- (Note: Available in Hive 0.6.0 and later)
      | ORC         -- (Note: Available in Hive 0.11.0 and later)
      | PARQUET     -- (Note: Available in Hive 0.13.0 and later)
      | AVRO        -- (Note: Available in Hive 0.14.0 and later)
      | JSONFILE    -- (Note: Available in Hive 4.0.0 and later)
      | INPUTFORMAT input_format_classname OUTPUTFORMAT output_format_classname
*/
```
<br>


* 실습을 위한 고객 테이블 (employee)을 생성합니다
```sql
# beeline> 
create table if not exists employee (
    emp_id string comment 'employee id',
    emp_name string comment 'employee name', 
    emp_salary bigint comment 'employee salary'
  )
  comment 'test employee table' 
  row format delimited 
  fields terminated by ','
  stored as textfile;
```
<br>


#### 2-2-2. 테이블 목록 조회 - SHOW
```sql
/** Usages
    SHOW TABLES [IN database_name];
*/
```
* 테이블 목록을 조회합니다 
```sql
# beeline> 
show tables;
```
<br>

* 부분일치 하는 테이블 목록을 조회합니다
  - like 연산자와 유사하게 동작합니다
```sql
# beeline> 
show tables 'emp*';
```
<br>


#### 2-2-3. 테이블 정보 조회 - DESCRIBE
```sql
/** Usages
    DESCRIBE [EXTENDED|FORMATTED] [db_name.] table_name[.col_name ( [.field_name])];
*/
```
* 테이블 기본 정보를 조회 합니다
  - EXTENDED : 부가정보를 출력합니다
  - FORMATTED : 부가정보를 포맷에 맞추어 출력합니다
```sql
# beeline> 
describe employee;
```
<details><summary> [실습] EXTENDED 및 FORMATTED 명령을 통해 테이블 정보를 조회합니다 </summary>

```sql
describe extended employee;
describe formatted employee;
```

</details>
<br>


#### 2-2-4. 테이블 삭제 - DROP
```sql
/** Usages
    DROP TABLE [IF EXISTS] table_name ;
*/
```
* 테이블을 삭제합니다
```sql
# beeline> 
drop table if exists employee;
show tables;
```
<br>


#### 2-2-5. 테이블 변경 - ALTER

> 테이블 변경 구문에는 RENAME, ADD COLUMNS 등의 구문이 존재합니다

* 테이블 이름 변경 - RENAME TO
```sql
/** Usages
    ALTER TABLE table_name RENAME TO new_table_name;
*/
```
* 고객 테이블을 생성합니다
```sql
# beeline> 
create table if not exists employee (
        emp_id string comment 'employee id',
        emp_name string comment 'employee name', 
        emp_salary bigint comment 'employee salary'
    )
    comment 'test employee table' 
    row format delimited 
    fields terminated by ','
    stored as textfile;
```

<details><summary>[실습] 테이블 이름을 `employee` 에서 `renamed_emp` 로 변경합니다 </summary>

```sql
# beeline>
alter table employee rename to renamed_emp;
show tables;
```
> 변경된 테이블이름(`renamed_emp`)가 나오면 정답입니다

</details>
<br>


* 테이블 컬럼 추가 - ADD COLUMNS
```sql
/** Usages
    ALTER TABLE table_name ADD COLUMNS (column1, column2) ;
*/
```
* 고객 테이블을 생성합니다
```sql
# beeline> 
create table if not exists employee (
    emp_id string comment 'employee id',
    emp_salary bigint comment 'employee salary'
  )
  comment 'test employee table' 
  row format delimited 
  fields terminated by ','
  stored as textfile;
```

<details><summary>[실습] 코멘트 'employee name' 을 가진 고객 이름(`emp_name` string) 컬럼을 추가하세요 </summary>

```sql
alter table employee add columns (
  emp_name string comment 'employee name', 
);
desc employee;
desc renamed_emp;
```
> 고객 이름이 추가되었다면 정답입니다

</details>
<br>


#### 2-2-6. 테이블 데이터 제거 - TRUNCATE

```sql
/** Usages
    TRUNCATE TABLE table_name;
*/
```
* 테이블에 임의의 데이터를 추가 후, 데이터를 조회합니다
  - 데이터 값은 자신의 이름으로 넣어도 좋습니다
```sql
# beeline> 
use testdb;
insert into renamed_emp values (1, 'suhyuk', 1000);
select * from renamed_emp;
```

<details><summary>[실습] TRUNCATE 구문으로 `renamed_emp` 테이블의 데이터를 삭제해 보세요 </summary>

```sql
# beeline>
truncate table renamed_emp;
select count(1) from renamed_emp;
```
> 결과가 0으로 나오면 정답입니다

</details>

[목차로 돌아가기](#4일차-아파치-하이브-데이터-적재)

<br>
<br>



### 2-3 하이브 DML 가이드

#### 2-3-1. LOAD

> 로컬(LOCAL) 혹은 클러스터 저장된 데이터를 하둡 클러스터에 업로드(Managed) 혹은 링크(External) 합니다

```sql
/** Usages
    LOAD DATA [LOCAL] INPATH 'filepath' [OVERWRITE] INTO TABLE tablename [PARTITION (partcol1=val1, partcol2=val2 ...)];
*/
```
* 테이블이 존재하면 제거하고, 실습을 위한 IMDB 영화(`imdb_movies`) 테이블을 생성합니다
```sql
# beeline> 
drop table if exists imdb_movies;

create table imdb_movies (
  rank int
  , title string
  , genre string
  , description string
  , director string
  , actors string
  , year string
  , runtime int
  , rating string
  , votes int
  , revenue string
  , metascore int
) row format delimited fields terminated by '\t';
```
<br>

* 생성된 테이블에 로컬에 존재하는 파일을 업로드합니다
```sql
load data local inpath '/opt/hive/examples/imdb.tsv' into table imdb_movies;
```

<details><summary>[실습] 별도 터미널을 통해 하둡 명령어로 적재된 파일을 확인해 보세요 </summary>

```bash
# terminal
docker compose exec hive-server bash
hadoop fs -ls /user/hive/warehouse/testdb/
```
> 적재된 테이블이 출력되면 정답입니다

</details>
<br>


#### 2-3-2. 데이터 조회 - SELECT

```sql
/** Usages
    SELECT [ALL | DISTINCT] select_expr, select_expr, ...
        FROM table_reference
        [WHERE where_condition]
        [GROUP BY col_list]
        [ORDER BY col_list [ASC | DESC]]
    [LIMIT [offset,] rows]
*/
```
<br>

* 테이블에 저장된 레코드를 SQL 구문을 통해서 조회합니다
  - SELECT : 출력하고자 하는 컬럼을 선택 
  - GROUP BY : 집계 연산을 위한 컬럼을 선택
  - ORDER BY : 정렬을 위한 컬럼을 선택 (ASC: 오름차순, DESC: 내림차순)
  - LIMIT : 조회 레코드의 수를 제한
* 제목 오름차순으로 장르와 제목을 조회합니다
```sql
# beeline> 
describe formatted imdb_movies;
select genre, title from imdb_movies order by title asc;
```

<details><summary>[실습] 랭킹(rank) 오름차순(ASC)으로 장르(genre), 제목(title) 정보를 상위 10개만 출력하세요 </summary>

```bash
# beeline>
select rank, genre, title from imdb_movies order by rank asc limit 10;
```
> 랭킹이 1 ~ 10위가 나오면 정답입니다

</details>
<br>


#### 2-3-3. 데이터 입력 - INSERT ... FROM
* 테이블로부터 또 다른 테이블에 레코드를 저장합니다 
  - INSERT INTO 는 기본 동작이 Append 로 항상 추가됩니다
```sql
/** Usages
    INSERT INTO TABLE tablename1 [PARTITION (partcol1=val1, partcol2=val2 ...)] select_statement1 FROM from_statement;
*/
```
* 제목만 가진 `imdb_title`이라는 테이블을 생성합니다
```sql
# beeline> 
create table if not exists imdb_title (title string);
```
<br>

* INSERT ... FROM 구문을 이용하여 `imdb_movies` 테이블로부터 제목만 읽어와서 저장합니다
```sql
insert into table imdb_title select title from imdb_movies limit 5;
select title from imdb_title;
```

<details><summary>[실습] 제목(title) 오름차순으로 5건, 내림차순으로 5건 각각 `imdb_title` 테이블에 입력하세요  </summary>

```sql
insert into table imdb_title select title from imdb_movies order by title asc limit 5;
select title from imdb_title;
insert into table imdb_title select title from imdb_movies order by title desc limit 5;
select title from imdb_title;
```
> 15건의 결과가 나오면 정답입니다

</details>
<br>


* 테이블에 해당 데이터를 덮어씁니다
  - INSERT OVERWITE 는 기본 동작이 Delete & Insert 로 삭제후 추가됩니다
```sql
/** Usages
    INSERT OVERWRITE TABLE tablename1 [PARTITION (partcol1=val1, ..) [IF NOT EXISTS]] select_statement FROM from_statement;
*/
```
<br>

* 제목만 가진 테이블에 OVERWRITE 키워드로 입력합니다
```sql
# beeline> 
create table if not exists imdb_title (title string);
insert overwrite table imdb_title select description from imdb_movies;
select title from imdb_title limit 5;
```
<br>


* 임의의 데이터를 직접 입력합니다 - INSERT VALUES
```sql
/** Usages
    INSERT INTO TABLE tablename [PARTITION (partcol1[=val1], partcol2[=val2] ...)] 
        VALUES values_row [, values_row ...];
*/
```
* 여러 레코드를 괄호를 통해서 입력할 수 있습니다
```sql
# beeline> 
insert into imdb_title values ('1 my first hive table record'), ('2 my second records'), ('3 third records');
```
<br>

* like 연산을 이용하여 특정 레코드만 가져옵니다
```sql
select title from imdb_title where title like '%record%';
```

<details><summary>[실습] `imdb_movies` 테이블로부터 OVERWRITE 옵션으로 모든 제목(title)을 `imdb_title` 테이블에 입력하세요 </summary>

```sql
insert overwrite table imdb_title select title from imdb_movies;
select count(1) from imdb_title;
```
> 1000개 결과가 나오면 정답입니다

</details>
<br>


#### 2-3-4. 테이블 데이터 삭제 - DELETE
> Hive 2.3.2 버전에서 ACID-based transaction 을 지원하는 것은 Bucketed ORC 파일만 지원합니다
  * [Hive Transactions](https://cwiki.apache.org/confluence/display/Hive/Hive+Transactions) 
```sql
/** Usages
    DELETE FROM tablename [WHERE expression]
*/
```
* 트랜잭션 설정을 위한 ORC `imdb_orc` 테이블을 생성합니다 
  - 아래와 같이 ORC 수행이 가능하도록 트랜잭션 설정이 사전에 수행되어야만 합니다
```sql
# beeline> 
create table imdb_orc (rank int, title string) clustered by (rank) into 4 buckets 
  stored as orc tblproperties ('transactional'='true');
set hive.support.concurrency=true;
set hive.enforce.bucketing=true;
set hive.exec.dynamic.partition.mode=nonstrict;
set hive.txn.manager=org.apache.hadoop.hive.ql.lockmgr.DbTxnManager;
set hive.compactor.initiator.on=true;
set hive.compactor.worker.threads=1;
```
<br>

* 해당 테이블에 2개의 레코드를 아래와 같이 입력합니다
```sql
insert into table imdb_orc values (1, 'psyoblade'), (2, 'psyoblade suhyuk'), (3, 'lgde course');
```

* 제대로 설정되지 않은 경우 아래와 같은 오류를 발생시킵니다
```sql
/**
  delete from imdb_orc where rank = 1;
  Error: Error while compiling statement: FAILED: SemanticException [Error 10294]: 
  Attempt to do update or delete using transaction manager that does not support these operations. (state=42000,code=10294)
*/
```

<details><summary>[실습] WHERE 절에 랭크(rank)가 1인 레코드를 삭제 후, 조회해 보세요 </summary>

```sql
delete from imdb_orc where rank = 2;
select * from imdb_orc;
```

</details>
<br>


#### 2-3-5. 컬럼 값 갱신 - UPDATE

> 대상 테이블의 컬럼을 업데이트 합니다. 단, 파티셔닝 혹은 버킷팅 컬럼은 업데이트 할 수 없습니다

```sql
/** Usages
    UPDATE tablename SET column = value [, column = value ...] [WHERE expression];
*/
```
* 랭크(rank)가 1인 값의 제목을 임의의 제목으로 변경합니다
```sql
# beeline> 
update imdb_orc set title = 'modified title' where rank = 1;
select * from imdb_orc;
```
<br>


#### 2-3-6. 테이블 백업 - EXPORT

> 테이블 메타데이터(\_metadata)와 데이터(data) 정보를 HDFS 경로에 백업 합니다

```sql
/** Usages
    EXPORT TABLE tablename [PARTITION (part_column="value"[, ...])] TO 'export_target_path' [ FOR replication('eventid') ];
*/
```
* 테이블을 하둡의 임의의 경로에 백업합니다
```sql
# beeline> 
export table imdb_orc to '/user/ubuntu/archive/imdb_orc';
```

<details><summary>[실습] 별도의 터미널을 통해 익스포트 된 결과를 확인합니다 </summary>

```bash
bash>
docker compose exec hive-server bash
hadoop fs -ls /user/ubuntu/archive/imdb_orc
-rwxr-xr-x   3 root supergroup       1244 2020-08-23 14:17 /user/ubuntu/archive/imdb_orc/_metadata
drwxr-xr-x   - root supergroup          0 2020-08-23 14:17 /user/ubuntu/archive/imdb_orc/data
```

</details>
<br>


#### 2-3-7. IMPORT

> 백업된 데이터로 새로운 테이블을 생성합니다

```sql
/** Usages
    IMPORT [[EXTERNAL] TABLE new_or_original_tablename [PARTITION (part_column="value"[, ...])]] 
      FROM 'source_path' [LOCATION 'import_target_path'];
*/
```
* 백업된 경로로부터 새로운 테이블을 생성합니다
```sql
# beeline> 
import table imdb_orc_imported from '/user/ubuntu/archive/imdb_orc';
select * from imdb_orc_imported;
```

<details><summary>[실습] `imdb_title` 테이블을 `/user/ubuntu/archive/imdb_title` 경로로 백업후, `imdb_recover` 테이블로 복원해 보세요 </summary>

```sql
export table imdb_title to '/user/ubuntu/archive/imdb_title';
import table imdb_recover from '/user/ubuntu/archive/imdb_title';
select * from imdb_recover;
```
* 아래와 유사한 결과가 나오면 정답입니다
```text
+----------------------------------------------------+
|                 imdb_recover.title                 |
+----------------------------------------------------+
| "Alexander and the Terrible, Horrible, No Good, Very Bad Day" |
| "Crazy, Stupid, Love."                             |
| "Hail, Caesar!"                                    |
| "Hello, My Name Is Doris"                          |
| "I, Daniel Blake"                                  |
| Zootopia                                           |
| Zoolander 2                                        |
| Zombieland                                         |
| Zodiac                                             |
| Zipper                                             |
+----------------------------------------------------+
```

</details>

[목차로 돌아가기](#4일차-아파치-하이브-데이터-적재)

<br>
<br>


## 2-4. 하이브 외부 저장소 테이블

> 하이브의 경우 local 데이터를 하둡에 load 하여 Managed 테이블을 생성할 수도 있지만, 대게 외부 데이터 수집 및 적재의 경우 External 테이블로 생성합니다

### 2-4-1. 매출 테이블의 외부 제공을 위해 외부 테이블로 생성합니다

> 로컬 경로에 수집되었던 테이블 parquet 파일이 존재하므로, 해당 파일을 이용하여 생성합니다

* 하이브 컨테이너로 접속합니다
```bash
# terminal
docker-compose exec hive-server bash
```
<br>

* 원본 파일의 스키마를 확인 및 파일을 하둡 클러스터에 업로드합니다
```
hadoop jar /tmp/source/parquet-tools-1.8.1.jar schema file:///tmp/source/user/20201025/2e3738ff-5e2b-4bec-bdf4-278fe21daa3b.parquet
```
```text
message purchase_20201025 {
  optional binary p_time (UTF8);
  optional int32 p_uid;
  optional int32 p_id;
  optional binary p_name (UTF8);
  optional int32 p_amount;
}
```
<br>

* 경로 확인 및 생성
```bash
hadoop fs -mkdir -p /user/lgde/purchase/dt=20201025
hadoop fs -mkdir -p /user/lgde/purchase/dt=20201026
hadoop fs -put /tmp/source/purchase/20201025/* /user/lgde/purchase/dt=20201025
hadoop fs -put /tmp/source/purchase/20201026/* /user/lgde/purchase/dt=20201026
```

* 하이브 명령 수행을 위해 beeline 을 실행합니다
```bash
beeline
```
* 콘솔로 접속하여 데이터베이스 및 테이블을 생성합니다 
```bash
# beeline>
!connect jdbc:hive2://localhost:10000 scott tiger
```
```sql
# beeline>
create database if not exists testdb comment 'test database' 
  location '/user/lgde/warehouse/testdb'
  with dbproperties ('createdBy' = 'lgde');
```
```sql
use testdb;

create external table if not exists purchase (
  p_time string
  , p_uid int
  , p_id int
  , p_name string
  , p_amount int
) partitioned by (dt string) 
row format delimited 
stored as parquet 
location 'hdfs:///user/lgde/purchase';
```
```sql
alter table purchase add if not exists partition (dt = '20201025') location 'hdfs:///user/lgde/purchase/dt=20201025';
alter table purchase add if not exists partition (dt = '20201026') location 'hdfs:///user/lgde/purchase/dt=20201026';
```
<br>


* 생성된 하이브 테이블을 조회합니다
```sql
# beeline>
show partitions purchase;
select * from purchase where dt = '20201025';
```
<br>

* 일자별 빈도를 조회합니다
```sql
# beeline>
select dt, count(1) as cnt from purchase group by dt;
```

### 2-4-2. 고객 테이블의 외부 제공을 위해 외부 테이블로 생성합니다

> 마찬가지로 유사한 방식으로 적재 및 테이블 생성을 수행합니다

* 하이브 컨테이너로 접속합니다
```bash
# terminal
docker-compose exec hive-server bash
```

* 파일 업로드 및 스키마 확인, 경로 생성 및 업로드

```bash
# docker
hadoop fs -mkdir -p /user/lgde/user/dt=20201025
hadoop fs -mkdir -p /user/lgde/user/dt=20201026
hadoop fs -put /tmp/source/user/20201025/* /user/lgde/user/dt=20201025
hadoop fs -put /tmp/source/user/20201026/* /user/lgde/user/dt=20201026
hadoop jar /tmp/source/parquet-tools-1.8.1.jar schema file:///tmp/source/purchase/20201025/38dc1f5b-d49d-436d-a84a-4e5c2a4022a5.parquet
```
```text
message user_20201025 {
  optional int32 u_id;
  optional binary u_name (UTF8);
  optional binary u_gender (UTF8);
  optional int32 u_signup;
}
```
<br>


* 하이브 명령 수행을 위해 beeline 을 실행합니다
```bash
beeline
```
* 하이브 테이블 생성 및 조회
```bash
# beeline>
!connect jdbc:hive2://localhost:10000 scott tiger
```
```sql
# beeline>
drop table if exists `user`;

create external table if not exists `user` (
  u_id int
  , u_name string
  , u_gender string
  , u_signup int
) partitioned by (dt string)
row format delimited 
stored as parquet 
location 'hdfs:///user/lgde/user';
```
```sql
alter table `user` add if not exists partition (dt = '20201025') location 'hdfs:///user/lgde/user/dt=20201025';
alter table `user` add if not exists partition (dt = '20201026') location 'hdfs:///user/lgde/user/dt=20201026';
```
<br>

* 생성된 결과를 확인합니다
```sql
# beeline>
select * from `user` where dt = '20201025';
select dt, count(1) as cnt from `user` group by dt;
```
<br>


### 2-4-3. Parquet 포맷과 Hive 테이블 데이터 타입
| Parquet | Hive | Description |
| - | - | - |
| int32 | int | 32비트 정수 |
| int64 | bigint | 64비트 정수 |
| float | float | 실수형 |
| double | double | 실수형 |
| binary | string | 문자열 |
<br>

[목차로 돌아가기](#4일차-아파치-하이브-데이터-적재)

<br>
<br>


## 2-4-4. 컨테이너 정리
* 테스트 작업이 완료되었으므로 모든 컨테이너를 종료합니다 (한번에 실행중인 모든 컨테이너를 종료합니다)
```bash
cd /home/ubuntu/work/data-engineer-basic-training/day4
docker compose down
```
<br>


### 참고 자료
  * [Hive Language Manual DDL](https://cwiki.apache.org/confluence/display/Hive/LanguageManual+DDL)
  * [Hive Language Manual DML](https://cwiki.apache.org/confluence/display/Hive/LanguageManual+DML)
  * [Top 7 Hive DDL Commands](https://data-flair.training/blogs/hive-ddl-commands/)
  * [Top 7 Hive DML Commands](https://data-flair.training/blogs/hive-dml-commands/)
  * [IMDB data from 2006 to 2016](https://www.kaggle.com/PromptCloudHQ/imdb-data)
  * [Hive update, delete ERROR](https://community.cloudera.com/t5/Support-Questions/Hive-update-delete-and-insert-ERROR-in-cdh-5-4-2/td-p/29485)

