# 3일차 데이터 엔지니어링 변환

> 아파치 스파크의 기본 명령어 및 API 를 주피터 노트북을 통해 실습하고 이해합니다


<br>


## 1. 최신버전 업데이트 테이블

> 원격 터미널에 접속하여 관련 코드를 최신 버전으로 내려받고, 과거에 실행된 컨테이너가 없는지 확인하고 종료합니다

### 1-1. 최신 소스를 내려 받습니다
```bash
# terminal
cd /home/ubuntu/work/data-engineer-basic-training
git pull
```
<br>

### 1-2. 실습을 위한 이미지를 내려받고 컨테이너를 기동합니다
```bash
# terminal
cd /home/ubuntu/work/data-engineer-basic-training/day3
docker-compose pull
docker-compose up -d
```
<br>

### 1-3. 스파크 실습을 위해 노트북 페이지에 접속합니다
* logs 출력에 localhost:8888 페이지를 크롬 브라우저에서 오픈합니다
```bash
# terminal
docker-compose ps

sleep 5
docker-compose logs notebook
```
> `http://127.0.0.1:8888/?token=87e758a1fac70558a6c4b4c5dd499d420654c509654c6b01` 이러한 형식의 URL 에서 `127.0.0.1` 을 자신의 호스트 이름(`vm<number>.aiffelbiz.co.kr`)으로 변경하여 접속합니다
<br>


## 2. 데이터 변환 기본

### [2-1. 스파크 기본 명령어 이해](http://htmlpreview.github.io/?https://github.com/psyoblade/data-engineer-basic-training/blob/master/day3/notebooks/html/lgde-pyspark-tutorial-1.html)
### [2-2. 기본 연산 다루기](http://htmlpreview.github.io/?https://github.com/psyoblade/data-engineer-basic-training/blob/master/day3/notebooks/html/lgde-pyspark-tutorial-2.html)
### [2-3. 데이터 타입 다루기](http://htmlpreview.github.io/?https://github.com/psyoblade/data-engineer-basic-training/blob/master/day3/notebooks/html/lgde-pyspark-tutorial-3.html)
### [2-4. 조인 연산 다루기](http://htmlpreview.github.io/?https://github.com/psyoblade/data-engineer-basic-training/blob/master/day3/notebooks/html/lgde-pyspark-tutorial-4.html)
### [2-5. 집계 연산 다루기](http://htmlpreview.github.io/?https://github.com/psyoblade/data-engineer-basic-training/blob/master/day3/notebooks/html/lgde-pyspark-tutorial-5.html)
### [2-6. 스파크 JDBC to MySQL](http://htmlpreview.github.io/?https://github.com/psyoblade/data-engineer-basic-training/blob/master/day3/notebooks/html/lgde-pyspark-tutorial-6.html)
<br>


### 3. 컨테이너 정리
* 테스트 작업이 완료되었으므로 모든 컨테이너를 종료합니다 (한번에 실행중인 모든 컨테이너를 종료합니다)
```bash
cd /home/ubuntu/work/data-engineer-basic-training/day3
docker-compose down
```
