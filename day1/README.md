# 데이터 엔지니어링 초급 1일차
> AWS 환경 구성, Git 및 Docker 명령어 실습을 통해 기본적인 도구를 손에 익힙니다.
> 가상의 인터넷 쇼핑몰 "LGDE" 사이트에서 발생하는 다양한 로그를 통해 고객을 분석하고, 의사결정을 위한 지표를 생성하는 시나리오를 경험합니다

- 목차
  * [1. AWS 환경 구성](#1-AWS-환경-구성)
  * [2. Git 명령어 실습](#2-lit-명령어-실습)
  * [3. Docker 명령어 실습](#3-Docker-명령어-실습)
  * [4. LGDE 서비스 시나리오](#4-LGDE-서비스-시나리오)

## 1. AWS 환경 구성
> 

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
```

### 2.2 helloworld.py 파일을 수정하고, 원래 파일의 상태로 되돌립니다
```bash
bash> echo "print('helloworld')" >> helloworld.py
bash> python helloworld.py

bash> git status -sb
bash> git diff

bash> git checkout -- .
bash> python helloworld.py
```

### 2.3 임의의 파일을 추가하고 스테이징 상태까지 갔다가 다시 원래 상태로 되돌립니다
```bash
bash> touch XXX
bash> git add XXX  # 지정한 하나의 파일만 스테이징 합니다
bash> git status -sb

bash> git reset -- .
bash> git status -sb
```

### 2.4 임의의 파일을 추가한 뒤, 커밋 이후에 다시 원래 상태로 롤백합니다
```bash
bash> touch YYY
bash> git status -sb

bash> git add -A  # 변경된 모든 파일을 추가합니다
bash> git commit -am "[추가] 파일추가"  # 파일추가 메시지를 포함하여 커밋합니다

bash> git status -sb
bash> git log  # 마지막으로 수정된 "파일추가" 메시지가 있는 커밋로그ID 값을 확인합니다

bash> git revert <git log 에서 복사한 commit id>  # 입력하면 vim 편집기가 뜨는데 Esc 키를 2회 이상 눌러 명령어 모드로 바꾼 뒤, ":wq" 명령어를 입력하여 저장합니다
```

### 2.5 임의의 가비지 파일을 10개 생성하고, 깃 클린 명령어를 통해 정리합니다
```bash
bash> mkdir -p tmp
bash> for x in $(seq 1 10); do touch tmp/XXX_$x; done

bash> git clean -n  # 명령으로 삭제될 대상 파일을 확인하고
bash> git clean -f  # 명령으로 삭제합니다
bash> rm -rf tmp
bash> git status -sb
```




## 3. Docker 명령어 실습
> 

## 4. LGDE 서비스 시나리오
> 인터넷 쇼핑몰 "LGDE.com" 지표 개발 시나리오



