# 1일차. 데이터 엔지니어링 기본

> 전체 과정에서 사용하는 기본적인 명령어 혹은 서비스(git, docker, docker-compose, linux, hdfs, sql) 등에 대해 실습하고 사용법을 익힙니다.

- 목차
  * [1. 클라우드 장비에 접속](#1-클라우드-장비에-접속)
  * [2. Git 명령어 실습](#2-Git-명령어-실습)
    - [2-1. Git 기본 명령어](#Git-기본-명령어)
  * [3. Docker 명령어 실습](#3-Docker-명령어-실습)
    - [3-1. Docker 기본 명령어](#Docker-기본-명령어)
  * [4. Docker Compose 명령어 실습](#4-Docker-Compose-명령어-실습)
    - [4-1. Docker Compose 기본 명령어](#Docker-Compose-기본-명령어)
  * [5. Linux 커맨드라인 명령어 실습](#5-Linux-커맨드라인-명령어-실습)
    - [5-1. Linux 기본 명령어](#Linux-기본-명령어)
  * [6. Hadoop 커맨드라인 명령어 실습](#6-Hadoop-커맨드라인-명령어-실습)
    - [6-1. Hadoop 기본 명령어](#Hadoop-기본-명령어)
  * [7. SQL 기본 실습](#7-SQL-기본-실습)
  * [8. 참고 자료](#8-참고-자료)
<br>


## 1. 클라우드 장비에 접속

> 개인 별로 할당 받은 `ubuntu@vm<number>.aiffelbiz.co.kr` 에 putty 혹은 terminal 을 이용하여 접속합니다


### 1-1. 원격 서버로 접속합니다
```bash
# terminal
# ssh ubuntu@vm001.aiffelbiz.co.kr
# password: ******
```

### 1-2. 패키지 설치 여부를 확인합니다
```bash
docker --version
docker-compose --version
git --version
```

<details><summary>[실습] 출력 결과 확인</summary>

> 출력 결과가 오류가 발생하지 않고, 아래와 같다면 성공입니다

```text
Docker version 20.10.6, build 370c289
docker-compose version 1.29.1, build c34c88b2
git version 2.17.1
```

</details>

[목차로 돌아가기](#1일차-데이터-엔지니어링-기본)

<br>
<br>


## 2. Git 명령어 실습

> 모든 데이터 엔지니어링 작업은 **코드와 리소스로 구성**되어 있으며, 이에 대한 *형상관리를 하는 것이 가장 기본*입니다. *모든 수정내역 및 배포 내역은 반드시 형상관리 도구(SourceSafe, Subversion, Git 등)를 통해 운영관리* 되어야만, 만일의 상황에 대비할 수 있습니다. 

* Git 의 필요성
  - 애플리케이션 배포 이후 운영 과정에서 버그가 발생했을 때 Stable 버전으로 롤백해야 하는 경우
  - 다수의 사람이 동일한 프로젝트 혹은 애플리케이션 개발에 참여하여 진행되는 경우 유용함
  - 회사 혹은 메인 레포지토리와 항상 연결되기 어렵거나 인터넷 연결이 되지 않는 상황에도 개발에 용이
  - 개발 과정에서 다양한 방법으로 개발해보고, 버리거나 혹은 적용하는 상황에 Branch 를 활용한 개발이 용이
  - 클라이언트 장비의 오류나 다양한 장애 상황에서도 주기적으로 동기화된 코드의 안전성 보장
<br>

### Git 기본 명령어

### 2-1. 초기화

#### 2-1-1. init : 현재 디렉토리를 Git 레포지토리로 초기화 하고, 로컬 레포지토리로 관리됩니다
  - `.git` 경로가 생성되고, 하위에 index 및 object 들이 존재합니다
```bash
# git init
mkdir -p /home/ubuntu/work/git
cd /home/ubuntu/work/git
git init
```
  - tree 명령어로 `.git` 내부가 어떻게 구성되어 있는지 확인합니다
```bash
tree .git
```

#### 2-1-2 clone : 원격 저장소의 내용을 로컬 저장소에 다운로드 합니다
  - target directory 를 지정하지 않으면 프로젝트이름(`test`)이 자동으로 생성됩니다
```bash
# git clone [uri]
cd /home/ubuntu/work
git clone https://github.com/psyoblade/test.git
ls -al test/*
```

<details><summary>[실습] 터미널에 접속하여 /home/ubuntu/work 경로 아래에 https://github.com/psyoblade/helloworld.git 을 clone 하세요 </summary>

> 출력 결과가 오류가 발생하지 않고, 아래와 유사하다면 성공입니다

```bash
cd /home/ubuntu/work
git clone https://github.com/psyoblade/helloworld.git
# Cloning into 'helloworld'...
# remote: Enumerating objects: 86, done.
# remote: Counting objects: 100% (40/40), done.
# remote: Compressing objects: 100% (29/29), done.
# remote: Total 86 (delta 14), reused 34 (delta 8), pack-reused 46
# Unpacking objects: 100% (86/86), done.
```

</details>
<br>



### 2-2. 스테이징

#### 2-2-1. 기본 환경 구성

> 기본 실습 환경 구성 및 단축 명령어를 등록합니다 

```bash
cd /home/ubuntu/work/helloworld

sudo ./init.sh basic  # 명령을 통해 tree 패키지 및 rc 파일을 복사합니다
d # alias 로 docker-compose 를 등록되어 --help 가 뜨면 정상입니다
source ~/.bashrc  # .bashrc 내용을 현재 세션에 다시 로딩합니다
```
* 로컬에 기본 정보를 입력합니다
```bash
name="lgde"
email="engineer@lgde.com"
```
```bash
git config --global user.name $name
git config --global user.email $email
```
<br>


#### 2-2-2. add : 저장 대상 파일(들)을 인덱스에 스테이징 합니다
  - 빈 디렉토리는 추가되지 않으며, 하나라도 파일이 존재해야 추가됩니다
  - 모든 Unstage 된 파일을 추가하는 옵션(-A)은 주의해서 사용해야 하며 .gitignore 파일을 잘 활용합니다
```bash
# git add (-A, --all) [file]
touch README.md
git add README.md
git status
```
<br>


#### 2-2-3. reset : 스테이징 된 파일을 언스테이징 합니다
```bash
# git reset [file]
git reset README.md
```
<br>


#### 2-2-4. status : 현재 경로의 스테이징 상태를 보여줍니다
```bash
# git status (-s, --short)
git status -s
```
<br>


#### 2-2-5. diff : 스테이징 된 파일에 따라 발생하는 이전 상태와 차이점을 보여줍니다
```bash
# git diff (--name-only)
echo "hello lgde" >> README.md
git add README.md
git commit -am "[수정] 초기"
```
```bash
echo "hello again" >> README.md
git diff
```
<br>


#### 2-2-6. commit : 스테이징(add) 된 내역을 스냅샷으로 저장합니다
  - 스테이징 된 내역이 없다면 커밋되지 않습니다
```bash
# git commit -m "descriptive message"
git status -s
git add README.md
git status -s
git commit -m "[수정] README 추가"
git status -s
```
<br>

> 수정된 파일은 " M" 으로 표현되고, 스테이징된 파일은  "M " 으로 표현되며, 커밋된 파일은 status 에서 보이지 않습니다.

![git.1](images/git.1.png)

<br>



### 2-3. 브랜치

#### 2-3-1. branch : 로컬(-r:리모트, -a:전체) 브랜치 목록을 출력, 생성, 삭제 작업을 수행합니다
```bash
# git branch (-r, --remotes | -a, --all)
git branch -a
```
```bash
# git branch [create-branch]
git branch lgde/2021
git branch -a
```
```bash
# git branch (-d, --delete) [delete-branch]
git branch -d lgde/2021
```
```bash
git branch -a
```
<br>


#### 2-3-2. checkout : 해당 브랜치로 이동합니다
  - 존재하는 브랜치로만 체크아웃이 됩니다 (-b 옵션을 주면 생성하면서 이동합니다)
  - 이미 존재하는 경우에는 -b 옵션을 쓰면 오류가 발생합니다
```bash
# git checkout (-b) [branch-name]
git checkout -b lgde/2021
```
<br>


#### 2-3-3. merge : 대상 브랜치와 병합합니다. **대상 브랜치는 영향이 없고, 현재 브랜치가 변경**됩니다.
  - 병합을 실습하기 위해 master 브랜치에서 수정후 커밋 합니다
  - 아까 생성했던 lgde/2021 브랜치에서 수정내역을 확인 후 병합합니다
  - 변경하고자 하는 브랜치를 먼저 체크아웃하는 습관을 가지시면 좋습니다
```bash
git checkout master
echo "modified" >> README.md
cat README.md
git status -s
```
```bash
git commit -am "[수정] add modified"
```
```bash
git checkout lgde/2021
cat README.md
```
```bash
# git merge [merge-branch]
git merge master
git commit -am "[병합] master"
cat README.md
```
```bash
# master 브랜치로 돌아옵니다
git checkout master
```
<br>


#### 2-3-4. log : 커밋 메시지를 브랜치 히스토리 별로 확인할 수 있습니다
```bash
git log
```
<br>


#### 2-3-5. 변경 상태 확인하기

<details><summary>[실습] LGDE.txt 파일생성 후에 스테이징(add) 후에 상태를 확인하세요 </summary>

```bash
git checkout master
touch LGDE.txt
git add LGDE.txt
git status
```

> 출력 결과가 오류가 발생하지 않고, 아래와 유사하다면 성공입니다

```text
On branch master
Your branch is up to date with 'origin/master'.

Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

  	new file:   LGDE.txt
```

</details>
<br>


#### 2-3-6. 실수로 삭제된 파일을 복구하기

```bash
cd /home/ubuntu/work/helloworld
rm *
ls -al
```
* 다음과 같이 `--` 키워드와 함께 대상을 지정하면 stage/commit 외의 수정 사항을 되돌립니다
  - `--` : 이 키워드 이후에 나오는 항목을 파일명으로 인식합니다
```bash
git checkout -- .
git status -sb
ls -al
```
<br>


#### 2-3-7. 브랜치가 꼬여서 난감할 때

> 복잡한 작업을 하다보면 꼬여서 곤란한 경우가 있는데 이 때에 해당 시점으로 reset 할 수 있습니다

```bash
cd /home/ubuntu/work/helloworld
git reflog
```
```bash
# clone 한 시점의 HEAD 번호로 리셋 후, 일부 수정된 사항은 checkout 하시면 정리가 됩니다
# git reset HEAD@{25}
# git checkout -- .
```
<br>


#### 2-3-8. 자주 사용하는 깃 명령어

> 여기의 명령어만 이해하고 있어도 기본 과정에서 불편함은 없습니다. 복구하기 어려운 상황이 생기면 *경로를 제거하고 다시 clone 받*으시면 됩니다. :-)

* `git clone`                      : 프로젝트 가져오기
* `git status -sb`                 : 브랜치 + 상태
* `git commit -am "[수정] 메시지"` : 스테이징 + 커밋
* `git pull`                       : 작업 시작시에 가장 먼저 해야 하는 명령어
* `git push`                       : 작업이 완료되면 푸시
* `git checkout -- .`              : 수정한 내역 버리고 마지막 커밋 시점으로 롤백

[목차로 돌아가기](#1일차-데이터-엔지니어링-기본)

<br>



## 3. Docker 명령어 실습

> 컨테이너 관리를 위한 도커 명령어를 실습합니다

* 실습을 위해 기존 프로젝트를 삭제 후 다시 클론합니다

```bash
# terminal
cd /home/ubuntu/work
rm -rf /home/ubuntu/work/helloworld
git clone https://github.com/psyoblade/helloworld.git
cd /home/ubuntu/work/helloworld
```
<br>

### Docker 기본 명령어

### 3-1. 컨테이너 생성관리

> 도커 이미지로 만들어져 있는 컨테이너를 생성, 실행 종료하는 명령어를 학습합니다

#### 3-1-1. create : 컨테이너를 생성합니다 
  - <kbd>--name <container_name></kbd> : 컨테이너 이름을 직접 지정합니다 (지정하지 않으면 임의의 이름이 명명됩니다)
  - 로컬에 이미지가 없다면 다운로드(pull) 후 컨테이너를 생성까지만 합니다 (반드시 -it 옵션이 필요합니다)
  - 생성된 컨테이너는 실행 중이 아니라면 `docker ps -a` 실행으로만 확인이 가능합니다
```bash
# docker create <image>:<tag>
docker create -it ubuntu:18.04
```
<br>

#### 3-1-2. start : 생성된 컨테이너를 기동합니다
  - 예제의 `busy_herschel` 는 자동으로 생성된 컨테이너 이름입니다
```bash
# 아래 명령으로 현재 생성된 컨테이너의 이름을 확인합니다
docker ps -a
```
  - 아래와 같이 임의의 이름이 생성되므로 변수명으로 지정해 둡니다
```bash
# CONTAINER ID   IMAGE          COMMAND   CREATED         STATUS    PORTS     NAMES
# e8f66e162fdd   ubuntu:18.04   "bash"    2 seconds ago   Created             busy_herschel
container_name="busy_herschel"
```
```bash
# docker start <container_name> 
docker start ${container_name}
```
```bash
# 해당 컨테이너의 우분투 버전을 확인합니다
docker exec -it ${container_name} bash
cat /etc/issue
exit
```
<br>


#### 3-1-3. stop : 컨테이너를 잠시 중지시킵니다
  - 해당 컨테이너가 삭제되는 것이 아니라 잠시 실행만 멈추게 됩니다
```bash
# docker stop <container_name>
docker stop ${container_name} 
```
<br>


#### 3-1-4. rm : 중단된 컨테이너를 삭제합니다
  - <kbd>-f, --force</kbd> : 실행 중인 컨테이너도 강제로 종료합니다 (실행 중인 컨테이너는 삭제되지 않습니다)
```bash
# docker rm <container_name>
docker rm ${container_name} 
```
<br>


#### 3-1-5. run : 컨테이너의 생성과 시작을 같이 합니다 (create + start)
  - <kbd>--rm</kbd> : 종료 시에 컨테이너까지 같이 삭제합니다
  - <kbd>-d, --detach</kbd> : 터미널을 붙지않고 데몬 처럼 백그라운드 실행이 되게 합니다
  - <kbd>-i, --interactive</kbd> : 인터액티브하게 표준 입출력을 키보드로 동작하게 합니다
  - <kbd>-t, --tty</kbd> : 텍스트 기반의 터미널을 에뮬레이션 하게 합니다
```bash
# docker run <options> <image>:<tag>
docker run --rm --name ubuntu20 -dit ubuntu:20.04
```
```bash
# 터미널에 접속하여 우분투 버전을 확인합니다
docker exec -it ubuntu20 bash
cat /etc/issue
```
<br>


#### 3-1-6. kill : 컨테이너를 종료합니다
```bash
# docker kill <container_name>
docker kill ubuntu20
```
<br>


### 3-2. 컨테이너 모니터링

#### 3-2-1. ps : 실행 중인 컨테이너를 확인합니다
  - <kbd>-a</kbd> : 실행 중이지 않은 컨테이너까지 출력합니다
```bash
docker ps
```

#### 3-2-2. logs : 컨테이너 로그를 표준 출력으로 보냅니다
  - <kbd>-f</kbd> : 로그를 지속적으로 tailing 합니다
  - <kbd>-p</kbd> : 호스트 PORT : 게스트 PORT 맵핑
```bash
docker run --rm -p 8888:80 --name nginx -dit nginx
```
```bash
# docker logs <container_name>
docker logs -f nginx
```
```bash
# terminal
curl localhost:8888
```
> 혹은 `http://vm001.aiffelbiz.co.kr:8888` 브라우저로 접속하셔도 됩니다 (여기서 vm001 은 개인 클라우드 컴퓨터의 호스트 이름이므로 각자의 호스트 이름으로 접근하셔야 합니다)
<br>


#### 3-2-3. top : 컨테이너에 떠 있는 프로세스를 확인합니다
```bash
# docker top <container_name> <ps options>
docker top nginx
```

<br>



### 3-3. 컨테이너 상호작용

#### 3-3-1. cp :  호스트에서 컨테이너로 혹은 반대로 파일을 복사합니다
```bash
# docker cp <container_name>:<path> <host_path> and vice-versa
docker run --rm --name ubuntu20 -dit ubuntu:20.04
docker cp ./helloworld.sh ubuntu20:/tmp
```

#### 3-3-2. exec : 컨테이너 내부에 명령을 실행합니다 
```bash
# docker exec <container_name> <args>
docker exec ubuntu20 /tmp/helloworld.sh
```

#### 3-3-3. 사용한 모든 컨테이너를 종료합니다

* 직접 도커로 실행한 작업은 도커 명령을 이용해 종료합니다
```bash
docker rm -f `docker ps -a | grep -v CONTAINER | awk '{ print $1 }'`
```

[목차로 돌아가기](#1일차-데이터-엔지니어링-기본)

<br>



## 4. Docker Compose 명령어 실습

> 도커 컴포즈는 **도커의 명령어들을 반복적으로 수행되지 않도록 yml 파일로 저장해두고 활용**하기 위해 구성되었고, *여러개의 컴포넌트를 동시에 기동하여, 하나의 네트워크에서 동작하도록 구성*한 것이 특징입니다. 내부 서비스들 간에는 컨테이너 이름으로 통신할 수 있어 테스트 환경을 구성하기에 용이합니다. 
<br>

### 실습을 위한 기본 환경을 가져옵니다

```bash
# terminal
cd /home/ubuntu/work
git clone https://github.com/psyoblade/data-engineer-${course}-training.git
cd /home/ubuntu/work/data-engineer-${course}-training/day1
```
<br>

### Docker Compose 기본 명령어

### 4-1. 컨테이너 관리

> 도커 컴포즈는 **컨테이너를 기동하고 작업의 실행, 종료 등의 명령어**를 주로 다룬다는 것을 알 수 있습니다. 아래에 명시한 커맨드 외에도 도커 수준의 명령어들(pull, create, start, stop, rm)이 존재하지만 잘 사용되지 않으며 일부 deprecated 되어 자주 사용하는 명령어 들로만 소개해 드립니다

#### 4-1-1. up : `docker-compose.yml` 파일을 이용하여 컨테이너를 이미지 다운로드(pull), 생성(create) 및 시작(start) 시킵니다
  - <kbd>-f <filename></kbd> : 별도 yml 파일을 통해 기동시킵니다 (default: `-f docker-compose.yml`)
  - <kbd>-d, --detach <filename></kbd> : 서비스들을 백그라운드 모드에서 수행합니다
  - <kbd>-e, --env `KEY=VAL`</kbd> : 환경변수를 전달합니다
  - <kbd>--scale <service>=<num></kbd> : 특정 서비스를 복제하여 기동합니다 (`container_name` 충돌나지 않도록 주의)
```bash
# docker-compose up <options> <services>
docker-compose up -d
```
<br>

#### 4-1-2. down : 컨테이너를 종료 시킵니다
  - <kbd>-t, --timeout <int> <filename></kbd> : 셧다운 타임아웃을 지정하여 무한정 대기(SIGTERM)하지 않고 종료(SIGKILL)합니다 (default: 10초)
```bash
# docker-compose down <options> <services>
docker-compose down
```
<br>


### 4-2. 기타 자주 사용되는 명령어

#### 4-2-1. exec : 컨테이너에 커맨드를 실행합니다
  - <kbd>-d, --detach</kbd> : 백그라운드 모드에서 실행합니다
  - <kbd>-e, --env `KEY=VAL`</kbd> : 환경변수를 전달합니다
  - <kbd>-u, --user <string></kbd> : 이용자를 지정합니다
  - <kbd>-w, --workdir <string></kbd> : 워킹 디렉토리를 지정합니다
```bash
# docker-compose exec [options] [-e KEY=VAL...] [--] SERVICE COMMAND [ARGS...]
docker-compose up -d
docker-compose exec ubuntu echo hello world
```
<br>

#### 4-2-2. logs : 컨테이너의 로그를 출력합니다
  - <kbd>-f, --follow</kbd> : 출력로그를 이어서 tailing 합니다
```bash
# terminal
docker-compose logs -f ubuntu
```
<br>

#### 4-2-3. pull : 컨테이너의 모든 이미지를 다운로드 받습니다
  - <kbd>-q, --quiet</kbd> : 다운로드 메시지를 출력하지 않습니다 
```bash
# terminal
docker-compose pull
```
<br>

#### 4-2-4. ps : 컨테이너 들의 상태를 확인합니다
  - <kbd>-a, --all</kbd> : 모든 서비스의 프로세스를 확인합니다
```bash
# terminal
docker-compose ps -a
```
<br>

#### 4-2-5. top : 컨테이너 내부에 실행되고 있는 프로세스를 출력합니다
```bash
# docker-compose top <services>
docker-compose top mysql
docker-compose top namenode
```

#### 4-2-6. 사용한 모든 컨테이너를 종료합니다

* 컴포즈를 통해 실행한 작업은 컴포즈를 이용해 종료합니다
```bash
docker-compose down
```


[목차로 돌아가기](#1일차-데이터-엔지니어링-기본)

<br>



## 5. Linux 커맨드라인 명령어 실습

> 리눅스 터미널 환경에서 활용할 수 있는 CLI 도구들을 소개하고 실습합니다. 대부분의 **오픈소스 인프라 및 서비스는 리눅스 서버 환경**에서 운영되며, 장애 혹은 서비스 모니터링 환경에서 디버깅의 가장 기본이 되는 것이 리눅스 커맨드라인 도구들이며, 독립적인 도구들로 하나의 실행파일로 가성비가 가장 높은 효과적인 도구들이기도 합니다


### 환경 구성 및 예제 데이터 다운로드
```bash
# terminal
cd /home/ubuntu/work
git clone https://github.com/psyoblade/linux-for-dummies
cd /home/ubuntu/work/linux-for-dummies
```

### Linux 기본 명령어

### 5-1. 수집 및 탐색

> 수집 및 탐색을 위한 다양한 도구([wget](https://www.gnu.org/software/wget/), [w3m](http://w3m.sourceforge.net/), [lynx](https://invisible-island.net/lynx/))들이 많지만, 하나로 통일해서 사용하는 것이 혼란을 줄일 수 있어, 가장 널리 사용되는 curl 에 대해서만 학습합니다

#### 5-1-1. curl : URL 을 통해 데이터를 송수신 하는 명령어

<br>


### 5-2. 출력 및 확인

#### 5-2-1. cat : 텍스트 파일의 내용을 출력
  - <kbd>-n, --number</kbd> : 라인 번호를 출력
```bash
# cat [OPTION] ... [FILE] ... 
cat -n helloworld.py
```
<br>

#### 5-2-2. more : 텍스트 파일의 일부를 지속적으로 출력

  - <kbd>-p</kbd> : 화면을 지우고 위에서부터 출력합니다
  - <kbd>-s</kbd> : 여러 줄의 빈 라인을 하나의 빈 라인으로 대체합니다
  - <kbd>-number</kbd> : 한 번에 출력하는 라인 수를 지정합니다
  - <kbd>+number</kbd> : 지정된 라인 부터 출력합니다
  - <kbd>+/string</kbd> : 지정된 문자열을 찾은 라인부터 출력합니다

```bash
# more [OPTIONS] ... [FILE] ... 
more -5 data/apache-access.log
```
> more 명령어는 <kbd>Q</kbd> 키를 통해서 빠져나올 수 있습니다

<details><summary>[실습] data/hadoop-hdfs-secondarynamenode.log 파일에서 exception 문자열이 발견된 위치부터 10줄씩 출력하세요 </summary>

> 출력 결과가 오류가 발생하지 않고, 아래와 유사하다면 성공입니다

```bash
more +/Exception -10 data/hadoop-hdfs-secondarynamenode.log
```

</details>
<br>

#### 5-2-3. head : 텍스트 파일의 처음부터 일부를 출력

  - <kbd>-c, --bytes=[-]NUM</kbd> : 첫 번째 NUM bytes 크기 만큼 출력하되, NUM 이 음수인 경우는 마지막 NUM bytes 를 제외한 전체를 출력합니다
    - `b: 512, kB 1000, K 1024, MB 1000*1000, M 1024*1024, GB 1000*1000*1000, G 1024*1024*1024, T, P, E, Z, Y`.
  - <kbd>-n, --lines=[-]NUM</kbd> : 파일의 처음부터 NUM 라인 수만큼 출력하고, 마찬가지로 음수 NUM 은 마지막 NUM 라인을 제외한 전체를 출력합니다
```bash
# head [OPTION] ... [FILE] ... 
head -c 1K data/apache-access.log > 1k.log
```
> 로그의 처음부터 1024 bytes 만큼 읽어서 파일을 생성합니다

<details><summary>[실습] data/apache-access.log 로그의 첫 번째 30라인만 출력하세요</summary>

```bash
head -n 30 data/apache-access.log
```

</details>
<br>

#### 5-2-4. tail : 텍스트 파일의 마지막부터 일부를 출력

  - <kbd>-c, --bytes=[+]NUM</kbd> : 첫 번째 NUM bytes 크기 만큼 출력하되, NUM 이 양수인 경우는 처음 NUM bytes 를 제외한 전체를 출력합니다
    - `b: 512, kB 1000, K 1024, MB 1000*1000, M 1024*1024, GB 1000*1000*1000, G 1024*1024*1024, T, P, E, Z, Y`.
  - <kbd>-f, --follow</kbd> : 파일에 추가되는 내용을 계속 출력합니다
  - <kbd>-F</kbd> : 파일이 접근되지 않는 경우에도 계속 재시도 합니다 (-f --retry 와 같은 효과)
  - <kbd>-n, --lines=[+]NUM</kbd> : 파일의 끝에서 NUM 라인 수만큼 출력하고, 마찬가지로 양수 NUM 은 처음 NUM 라인을 제외한 전체를 출력합니다
```bash
# tail [OPTION] ... [FILE] ...
tail -n 30 data/apache-access.log
```
> 로그의 마지막 30라인만 출력합니다

<details><summary>[실습] noexists.log 로그가 없어도 계속 tail 하고 해당 파일에 로그가 추가되면 계속 tailing 하는 명령을 수행하세요 </summary>

```bash
tail -F data/notexist.log
```
```bash
# 별도의 터미널에서 아래와 같이 파일생성 후 append 합니다
cd /home/ubuntu/work/linux-for-dummies
touch data/notexist.log
echo "hello world" >> data/notexist.log
```

</details>

[목차로 돌아가기](#1일차-데이터-엔지니어링-기본)

<br>



## 6. Hadoop 커맨드라인 명령어 실습

> 모든 Hadoop Filesystem 명령어는 hdfs 명령어를 사용해야만 분산저장소에 읽고, 쓰는 작업이 가능합니다

### 실습을 위한 환경을 확인합니다

* 하둡 명령어 실습을 위해서 컨테이너를 기동시키고, 하둡 네임노드 컨테이너에 접속합니다

```bash
# terminal
cd /home/ubuntu/work/data-engineer-${course}-training/day1
docker-compose pull
docker-compose up -d
```
```bash
# terminal 
docker-compose exec namenode bash
```
<br>

### Hadoop 기본 명령어

### 6-1. 파일/디렉토리 관리

#### 6-1-1. ls : 경로의 파일/디렉토리 목록을 출력합니다

  - <kbd>-d</kbd> : 디렉토리 목록만 출력합니다
  - <kbd>-h</kbd> : 파일크기를 읽기쉽게 출력합니다
  - <kbd>-R</kbd> : 하위노드까지 모두 출력합니다

```bash
# -ls [-d] [-h] [-R] [<path> ...]
hdfs dfs -mkdir /user
hdfs dfs -ls /user
```
<br>


### 6-2. 파일 읽고/쓰기

#### 6-2-1. text : 텍스트 파일(zip 압축)을 읽어서 출력합니다
  - <kbd>-ignoreCrc</kbd> : CRC 체크를 하지 않습니다
```bash
# -text [-ignoreCrc] <src>
rm -rf helloworld*
echo "hello world" > helloworld
gzip helloworld
```
```bash
hdfs dfs -mkdir /tmp
hdfs dfs -put helloworld.gz /tmp/
hdfs dfs -text /tmp/helloworld.gz
```
<br>


#### 6-2-2. cat : 텍스트 파일(plain)을 읽어서 출력합니다
  - <kbd>-ignoreCrc</kbd> : CRC 체크를 하지 않습니다
```bash
# -cat [-ignoreCrc] <src>
rm -rf helloworld*
echo "hello world" > helloworld
```
```bash
hdfs dfs -put helloworld /tmp/
hdfs dfs -cat /tmp/helloworld
```
<br>


#### 6-2-3. appendToFile : 소스 데이터를 읽어서 타겟 데이터 파일에 append 하며, 존재하지 않는 파일의 경우 생성됩니다
```bash
# -appendToFile <localsrc> ... <dst>
echo "hello lgde" > appended
hdfs dfs -appendToFile appended /tmp/helloworld
hdfs dfs -cat /tmp/helloworld
```
> 참고로 append 옵션은 설정상 적용되지 않을 수 있으며, 아래의 2가지 설정이 되어 있어야 동작합니다

| 키 | 값 | 설명 |
| --- | --- | --- |
| dfs.client.block.write.replace-datanode-on-failure.enable | true | If there is a datanode/network failure in the write pipeline, DFSClient will try to remove the failed datanode from the pipeline and then continue writing with the remaining datanodes. As a result, the number of datanodes in the pipeline is decreased. The feature is to add new datanodes to the pipeline. This is a site-wide property to enable/disable the feature. When the cluster size is extremely small, e.g. 3 nodes or less, cluster administrators may want to set the policy to NEVER in the default configuration file or disable this feature. Otherwise, users may experience an unusually high rate of pipeline failures since it is impossible to find new datanodes for replacement. See also dfs.client.block.write.replace-datanode-on-failure.policy |
| dfs.client.block.write.replace-datanode-on-failure.policy	 | DEFAULT | This property is used only if the value of dfs.client.block.write.replace-datanode-on-failure.enable is true. ALWAYS: always add a new datanode when an existing datanode is removed. NEVER: never add a new datanode. DEFAULT: Let r be the replication number. Let n be the number of existing datanodes. Add a new datanode only if r is greater than or equal to 3 and either (1) floor(r/2) is greater than or equal to n; or (2) r is greater than n and the block is hflushed/appended.|

<br>


### 6-3. 파일 업/다운 로드

#### 6-3-1. put : 분산 저장소로 파일을 저장합니다
  - <kbd>-f</kbd> : 존재하는 파일을 덮어씁니다
  - <kbd>-p</kbd> : 소유자 및 변경시간을 수정하지 않고 유지합니다 (preserve)
  - <kbd>-l</kbd> : 복제수를 1개로 강제합니다 (lazily persist)
```bash
# -put [-f] [-p] [-l] <localsrc> ... <dst>
echo "lgde ${course} course" > uploaded.txt
```
```bash
hdfs dfs -put ./uploaded.txt /tmp
```
<br>

#### 6-3-2. moveFromLocal : put 과 동일하지만 저장이 성공한 이후에 로컬 파일이 삭제됩니다
```bash
# -moveFromLocal <localsrc> ... <dst> 
hdfs dfs -moveFromLocal ./uploaded.txt /tmp/uploaded.org
```
```bash
ls -al *.txt
```
<br>


#### 6-3-3. get : 분산 저장소로부터 파일을 가져옵니다 
  - <kbd>-p</kbd> : 소유자 및 변경시간을 유지합니다 (preserve)
  - <kbd>-ignoreCrc</kbd> : CRC 체크를 하지 않습니다
  - <kbd>-crc</kbd> : CRC 체크썸을 같이 다운로드 합니다
```bash
# -get [-p] [-ignoreCrc] [-crc] <src> ... <localdst>
hdfs dfs -get /tmp/uploaded.org ./uploaded.txt
```
```bash
cat ./uploaded.txt
```
<br>


#### 6-3-4. getmerge : 디렉토리의 모든 파일을 하나로 묶어서 가져옵니다
  - <kbd>-nl</kbd> : 매 파일의 마지막에 줄바꿈 문자를 넣습니다
```bash
# -getmerge [-nl] <src> <localdst>
hdfs dfs -getmerge /tmp ./manyfiles
```
```bash
cat ./manyfiles
```
<br>


#### 6-3-5. copyToLocal : get 과 동일합니다
```bash
# -copyToLocal [-f] [-p] [-l] <localsrc> ... <dst>
hdfs dfs -copyToLocal /tmp/uploaded.txt ./uploaded.txt
```
<br>


### 6-4. 파일 복사/이동/삭제

#### 6-4-1. cp : 소스 데이터를 타겟으로 복사합니다
  - <kbd>-f</kbd> : 존재하는 파일을 덮어씁니다
  - <kbd>-p[topax]</kbd> : 소유자 및 수정시간을 유지합니다 (preserve)
    - `[topax] (timestamps, ownership, permission, ACLs, XAttr)`
    - `[topax]` 옵션을 주지 않은 경우 timestamps, ownership 만 유지됩니다
```bash
# -cp [-f] [-p | -p[topax]] <src> ... <dst>
hdfs dfs -mkdir /user/root
```
```bash
hdfs dfs -cp /tmp/helloworld /user/root
```
<br>

#### 6-4-2. mv : 소스 데이터를 타겟으로 이동합니다
```bash
# -mv <src> ... <dst>
hdfs dfs -mv hdfs:///tmp/uploaded.* /user/root
```
> 기본적으로 FileSystem 의 Scheme 명시하지 않으면 hdfs 를 바라보지만, Local FileSystem 에도 동일한 경로가 있는 경우 문제가 될 수 있으므로 명시적으로 hdfs:// 를 넣어주는 것이 좋습니다

```bash
hdfs dfs -ls hdfs:///user/root
```

<br>


#### 6-4-3. rm : 지정한 패턴에 매칭되는 모든 파일을 삭제합니다
  - <kbd>-f</kbd> : 파일이 존재하지 않아도 에러 메시지를 출력하지 않습니다
  - <kbd>-r|-R</kbd> : 하위 디렉토리까지 삭제합니다 (dfs -rmr 과 동일)
  - <kbd>-skipTrash</kbd> : trash 로 이동하지 않고 바로 삭제합니다
```bash
# -rm [-f] [-r|-R] [-skipTrash] <src> ...
# hdfs dfs -rm -f -r hdfs:///user/root
hdfs dfs -ls hdfs:///tmp
hdfs dfs -rm hdfs:///tmp/hello*
```
```bash
hdfs dfs -ls hdfs:///tmp
```
<br>


#### 6-4-4. mkdir : 디렉토리를 생성합니다
  - <kbd>-p</kbd> : 중간경로가 없어도 생성합니다
```bash
# -mkdir [-p] <path>
hdfs -mkdir -p /create/also/mid/path
hdfs dfs -ls hdfs:///user/root
```
```bash
hdfs dfs -mkdir -p hdfs:///user/root/foo
```
<br>


#### 6-4-5. rmdir : 디렉토리를 삭제합니다
  - <kbd>--ignore-fail-on-non-empty</kbd> : 와일드카드 삭제 시에 파일을 가진 디렉토리가 존재해도 오류를 출력하지 않습니다
    - 디렉토리 내에 파일이 존재하지 않아야 삭제가 됩니다
```bash
# -rmdir [--ignore-fail-on-non-empty] <dir> ...
hdfs dfs -rmdir hdfs:///user/root/foo
```
<br>

#### 6-4-6. touchz : 파일 크기가 0인 파일을 생성합니다
```bash
# -touchz <path> ...
hdfs dfs -touchz  /user/root/zero_size_file
hdfs dfs -ls hdfs:///user/root
```
> <kbd><samp>Ctrl</samp>+<samp>D</samp></kbd> 혹은 <kbd>exit</kbd> 명령으로 컨테이너에서 빠져나옵니다

[목차로 돌아가기](#1일차-데이터-엔지니어링-기본)

<br>



## 7. SQL 기본 실습

### 7-1. SQL 실습을 위해 root 유저로 데이터베이스 (foo) 생성

```bash
# terminal
docker-compose exec mysql mysql -uroot -proot
```
* sqoop 유저가 해당 데이터베이스를 사용할 수 있도록 권한 부여를 합니다
```sql
# mysql>
CREATE DATABASE foo;
GRANT ALL ON foo.* TO 'sqoop'@'%';
```
> <kbd><samp>Ctrl</samp>+<samp>D</samp></kbd> 혹은 <kbd>exit</kbd> 명령으로 컨테이너에서 빠져나옵니다
<br>


### 7-2. 테이블 확인 및 SQL 실습
```bash
# terminal
docker-compose exec mysql mysql -usqoop -psqoop
```
<br>


### 7-3. SQL 실습을 위해 sqoop 유저로 접속
```sql
# mysql>
use foo;
```
<br>


### 7-4. 기본 SQL 명령어 리마인드

![SQL](images/SQL.png)

#### 7-4-1. [테이블 생성](https://dev.mysql.com/doc/refman/8.0/en/create-table.html)

```sql
# mysql>
CREATE TABLE table1 (
    col1 INT NOT NULL,
    col2 VARCHAR(10)
);

CREATE TABLE table2 (
    col1 INT NOT NULL AUTO_INCREMENT,
    col2 VARCHAR(10) NOT NULL,
    PRIMARY KEY (col1)
);

CREATE TABLE foo (
    foo INT
);
```
```sql
SHOW TABLES;
```
<br>


#### 7-4-2. [테이블 변경](https://dev.mysql.com/doc/refman/8.0/en/alter-table.html)
```sql
# mysql>
ALTER TABLE foo ADD COLUMN ( bar VARCHAR(10) );
```
```sql
DESC foo;
```
<br>


#### 7-4-3. [테이블 삭제](https://dev.mysql.com/doc/refman/8.0/en/drop-table.html)
```sql
# mysql>
DROP TABLE foo;
```
```sql
SHOW TABLES;
```
<br>


#### 7-4-4. [데이터 추가](https://dev.mysql.com/doc/refman/8.0/en/insert.html)
```sql
# mysql>
INSERT INTO table1 ( col1 ) VALUES ( 1 );
INSERT INTO table2 VALUES ( 1, 'one' );
INSERT INTO table2 VALUES ( 2, 'two' ), ( 3, 'three' );
```
<br>


#### 7-4-5. [데이터 조회](https://dev.mysql.com/doc/refman/8.0/en/select.html)
```sql
# mysql>
SELECT col1, col2
FROM table1;
```
```sql
SELECT col2
FROM table2
WHERE col2 = 'two';
```
<br>


#### 7-4-6. [데이터 변경](https://dev.mysql.com/doc/refman/8.0/en/update.html)
```sql
# mysql>
UPDATE table1 SET col1 = 100 WHERE col1 = 1;
```
```sql
SELECT col1, col2 FROM table1;
```
<br>


#### 7-4-7. [데이터 삭제](https://dev.mysql.com/doc/refman/8.0/en/delete.html)
```sql
# mysql>
DELETE FROM table1 WHERE col1 = 100;
DELETE FROM table2;
```

> <kbd><samp>Ctrl</samp>+<samp>D</samp></kbd> 혹은 <kbd>exit</kbd> 명령으로 컨테이너에서 빠져나옵니다
<br>


### 7-5. 데이터베이스 삭제

> 테스트로 생성했던 foo 데이터베이스를 삭제합니다

```bash
# terminal
docker-compose exec mysql mysql -uroot -proot
```
```sql
# mysql>
drop database foo;
```
```sql
show databases;
```
> <kbd><samp>Ctrl</samp>+<samp>D</samp></kbd> 혹은 <kbd>exit</kbd> 명령으로 컨테이너에서 빠져나옵니다

[목차로 돌아가기](#1일차-데이터-엔지니어링-기본)

<br>
<br>


## 8. 참고 자료
* [Git Cheatsheet](https://education.github.com/git-cheat-sheet-education.pdf)
* [Docker Cheatsheet](https://dockerlabs.collabnix.com/docker/cheatsheet/)
* [Docker Compose Cheatsheet](https://devhints.io/docker-compose)
* [Compose Cheatsheet](https://buildvirtual.net/docker-compose-cheat-sheet/)
* [Hadoop Commands Cheatsheet](https://images.linoxide.com/hadoop-hdfs-commands-cheatsheet.pdf)
* [Linux Password](https://www.cyberciti.biz/faq/understanding-etcpasswd-file-format/)
* [Hadoop Append](https://community.cloudera.com/t5/Support-Questions/Where-can-I-set-dfs-client-block-write-replace-datanode-on/td-p/2529)

