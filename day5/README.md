# 5일차. LGDE.com 서비스 지표 실습
> 가상의 웹 쇼핑몰 LGDE.com 접속정보, 매출 및 고객정보를 통해 각종 지표를 생성하는 실습을 수행합니다

* 목차
  * [서버 기동 및 확인](#1-서버-기동-및-확인)
  * [스냅샷 및 파일 수집](#2-스냅샷-및-파일-수집)
  * [서비스 첫 날 지표 생성](#3-서비스-첫-날-지표-생성)
  * [서비스 둘째날 이후 지표 생성](#4-서비스-둘째날-이후-지표-생성)


## 1. 서버 기동 및 확인
```bash
bash> cd ~/workspace/data-engineer-basic-training/day5
bash> docker-compose up -d
bash> docker-compose ps

# 아래와 같이 http://127.0.0.1 로 시작하는 URL 에서 127.0.0.1 부분을 현재 aws-instance-host 이름으로 변경합니다
bash> docker-compose logs notebook | grep http
...
or http://127.0.0.1:8888/?token=ad4f43203ac46f7f7f58807ab6781b1fd18b9ca5066664df
...

chrome> http://<aws-hostname-or-ip>:8888/?token=ad4f43203ac46f7f7f58807ab6781b1fd18b9ca5066664df
```

## 2. 스냅샷 및 파일 수집

## 3. 서비스 첫 날 지표 생성

## 4. 서비스 둘째날 이후 지표 생성
