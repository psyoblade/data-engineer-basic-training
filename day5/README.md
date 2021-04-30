# 5일차. LGDE.com 서비스 지표 실습
> 가상의 웹 쇼핑몰 LGDE.com 접속정보, 매출 및 고객정보를 통해 각종 지표를 생성하는 실습을 수행합니다

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
  * [2-1. 스쿱 스냅샷 수집 실습](http://htmlpreview.github.io/?https://github.com/psyoblade/data-engineer-basic-training/blob/master/day5/notebooks/html/lgde-basic-day5-step1.html)
  * [2-2. 플루언트디 파일 수집 실습](http://htmlpreview.github.io/?https://github.com/psyoblade/data-engineer-basic-training/blob/master/day5/notebooks/html/lgde-basic-day5-step2.html)

## 3. 서비스 지표 생성
  * [3-1. LGDE.com 1일차 지표 실습](http://htmlpreview.github.io/?https://github.com/psyoblade/data-engineer-basic-training/blob/master/day5/notebooks/html/lgde-basic-day5-step3.html)
  * [3-2. LGDE.com 2일차 지표 실습](http://htmlpreview.github.io/?https://github.com/psyoblade/data-engineer-basic-training/blob/master/day5/notebooks/html/lgde-basic-day5-step4.html)

## 4. 서비스 지표 검증
  * [4-1. LGDE.com 1일차 지표 검증](http://htmlpreview.github.io/?https://github.com/psyoblade/data-engineer-basic-training/blob/master/day5/notebooks/html/lgde-basic-day5-step3-answer.html)
  * [4-2. LGDE.com 2일차 지표 검증](http://htmlpreview.github.io/?https://github.com/psyoblade/data-engineer-basic-training/blob/master/day5/notebooks/html/lgde-basic-day5-step4-answer.html)

