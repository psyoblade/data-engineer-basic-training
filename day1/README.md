# 데이터 엔지니어링 초급 1일차
> 전체 과정에서 사용하는 기본적인 명령어 혹은 서비스(git, docker, linux, hdfs, sql) 등에 대해 실습하고 사용법을 익힙니다

- 목차
  * [ssh](#ssh)
  * [git](#)
  * [docker](#)
  * [linux](#)
  * [hdfs](#)
  * [sql](#)



## 1. 클라우드 장비에 접속

> 개인 별로 할당 받은 `ubuntu@vm<number>.aiffelbiz.co.kr` 에 putty 혹은 terminal 을 이용하여 접속합니다

### 1-1. 원격 서버로 접속합니다
```bash
# terminal
# ssh ubuntu@vm<number>.aiffelbiz.co.kr
# password: ******
```

### 1-2. 패키지 설치 여부를 확인합니다
```bash
docker --version
docker-compose --version
git --version
```

<details><summary>[실습] 출력 결과 확인</summary>

> 출력 결과가 오류가 발생하지 않고, 아래와 유사하다면 성공입니다

```text
Docker version 20.10.6, build 370c289
docker-compose version 1.29.1, build c34c88b2
git version 2.17.1
```

</details>
<br>


#### 1-3. 실습을 위한 예제 프로젝트를 가져옵니다

> 아래에서 학습할 예정이지만, 원격지에 저장된 프로젝트를 로컬로 다운로드 하는 작업이 git clone 입니다

```bash
# terminal
mkdir -p /home/ubuntu/work
cd /home/ubuntu/work
git clone https://github.com/psyoblade/data-engineer-basic-training.git
git clone https://github.com/psyoblade/helloworld.git
```
<br>


## 2. Git 명령어 실습

> [Git Cheat-sheet](https://education.github.com/git-cheat-sheet-education.pdf) 를 참고하여 작성 되었습니다

### 2-1. 초기화
* init : 현재 디렉토리를 Git 레포지토리로 초기화 하고, 로컬 레포지토리로 관리됩니다
  - `.git` 경로가 생성되고, 하위에 index 및 object 들이 존재합니다
```bash
# git init
git init
```
* clone : 원격 저장소의 내용을 로컬 저장소에 다운로드 합니다
  - target directory 를 지정하지 않으면 프로젝트이름(`helloworld`)이 자동으로 생성됩니다
```bash
# git clone [uri]
git clone https://github.com/psyoblade/helloworld.git
```
<br>

<details><summary>[실습] 터미널에 접속하여 /home/ubuntu/work 경로 아래에 https://github.com/psyoblade/helloworld.git 을 clone 하세요 </summary>

> 출력 결과가 오류가 발생하지 않고, 아래와 유사하다면 성공입니다

```bash
Cloning into 'helloworld'...
remote: Enumerating objects: 86, done.
remote: Counting objects: 100% (40/40), done.
remote: Compressing objects: 100% (29/29), done.
remote: Total 86 (delta 14), reused 34 (delta 8), pack-reused 46
Unpacking objects: 100% (86/86), done.
```

</details>
<br>


#### 2-1-1. 기본 환경 구성

> 기본 실습 환경 구성 및 단축 명령어를 등록합니다 

```bash
cd /home/ubuntu/work/helloworld

sudo ./init.sh  # 명령을 통해 tree 패키지 및 rc 파일을 복사합니다
d # alias 로 docker-compose 를 등록되어 --help 가 뜨면 정상입니다
source ~/.bashrc  # .bashrc 내용을 현재 세션에 다시 로딩합니다
```
<br>


### 2-2. 스테이징
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


### 2-3. 브랜치

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


### 2-4. 경로 관리

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


### 2-5. 예외 처리

> 깃으로 관리되지 않는 파일 혹은 경로를 패턴을 통해 관리합니다 - [gitignore.io](https://www.toptal.com/developers/gitignore)

* .gitignore : 해당 파일을 생성하고 내부 파일을 아래와 같이 관리합니다
```bash
# cat .gitignore
logs/
*.notes
tmp/
```
<br>


### 2-6. 저장소 관리

> 원격 저장소와 동기화 하는 방법이며, pull, push 는 항상 conflict 에 유의해야 하며, 로컬 저장소에서 merge 및 conflict 해결하는 습관을 들여야만 합니다

* pull : 원격 저장소에서 변경된 내역을 로컬 저장소에 반영합니다
```bash
# git pull (--dry-run)
```

* push : 로컬 저장소의 커밋된 내역을 원격 저장소에 반영합니다
  - 원격 저장소에 브랜치가 존재하지 않는 경우에 업스트림 옵션(--set-upstream origin lgde/2021)을 활용합니다
```bash
# git push (--set-upstream <remote> <branch>)
```
<br>


### 2-7. 이력 관리
* reset : 스테이징된 모든 내역을 제거 혹은 제거된 내역을 롤백합니다
  - git log 명령을 통해 확인된 commit 해시 값으로 해당 시점으로 돌릴 수 있습니다
  - git reflog 명령을 통해 모든 이력을 확인할 수 있고, reset 을 undo 할 수 있습니다
```bash
# git reset --hard [commit]
git reset --hard 7e5e3e54e400228cbdb12ab00b13c4af22305a0d

# git reflog (show master)
git reset 'HEAD@{1}'
```
<br>


### 2-8. 임시 저장

* stash : 현재 수정내역을 커밋하기는 애매하지만, 다른 브랜치로 체크아웃 하고 싶을 때 임시로 수정 내역 전체를 저장합니다
```bash
# 임시로 저장
git stash

# 임시 저장 리스트
git stash list

# 가장 마지막에 저장한 것을 복원
git stash pop

# 가장 마지막에 저장된 것을 삭제
git stash drop

# 혹은 stash 값을 바로 사용
git stash apply stash@{0}

# 내역을 보고 싶다면
git stash show stash@{1}
```
<br>


### 2-9. 깃 명령어 톱 6

> 가장 많이 사용하는 명령어 입니다

```bash
git clone
git status -sb                    # 브랜치 + 상태
git commit -am "[수정] 메시지"    # 스테이징 + 커밋
git pull
git push
git checkout -- .                 # 수정한 내역 버리고 마지막 커밋 시점으로 롤백
```

#### 2-9-1. 파일생성 및 스테이징

<details><summary>[실습] LGDE.txt 파일생성 후에 스테이징 후에 상태를 확인하세요 </summary>

```bash
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


#### 2-9-2. 실수로 삭제된 파일을 복구하기

```bash
cd /home/ubuntu/work/helloworld
rm *
ls -al
```

<details><summary>[실습] 모든 코드를 원래 상태로 복구해 보세요</summary>

> 출력 결과가 오류가 발생하지 않고, 아래와 유사하다면 성공입니다

```bash
git checkout -- .
git statusb -sb
ls -al
```

</details>
<br>


## 3. Docker 명령어 실습

> [Docker Cheat Sheet](https://dockerlabs.collabnix.com/docker/cheatsheet/)를 참고하여 작성 되었습니다

### 3-1. 컨테이너 생성관리

> 도커 이미지로 만들어져 있는 컨테이너를 생성, 실행 종료하는 명령어를 학습합니다

* create : 컨테이너를 생성합니다 
  - <kbd>--name <container_name></kbd> : 컨테이너 이름을 직접 지정합니다 (지정하지 않으면 임의의 이름이 명명됩니다)
  - 로컬에 이미지가 없다면 다운로드(pull) 후 컨테이너를 생성까지만 합니다
  - 생성된 컨테이너는 실행 중이 아니라면 `docker ps -a` 실행으로만 확인이 가능합니다
```bash
# docker create <image>:<tag>
docker create -name ubuntu ubuntu:18.04
```

* start : 생성된 컨테이너를 기동합니다
  - 예제의 `busy_herschel` 는 자동으로 생성된 컨테이너 이름입니다
```bash
# docker start <container_name> 
docker start busy_herschel
```

* stop : 컨테이너를 잠시 중지시킵니다
  - 해당 컨테이너가 삭제되는 것이 아니라 잠시 실행만 멈추게 됩니다
```bash
# docker stop <container_name>
docker stop busy_herschel
```

* rm : 중단된 컨테이너를 삭제합니다
  - <kbd>-f, --force</kbd> : 실행 중인 컨테이너도 강제로 종료합니다 (실행 중인 컨테이너는 삭제되지 않습니다)
```bash
# docker rm <container_name>
docker rm busy_herschel
```

* run : 컨테이너의 생성과 시작을 같이 합니다 (create + start)
  - <kbd>--rm</kbd> : 종료 시에 컨테이너까지 같이 삭제합니다
  - <kbd>-d, --detach</kbd> : 터미널을 붙지않고 데몬 처럼 백그라운드 실행이 되게 합니다
  - <kbd>-i, --interactive</kbd> : 인터액티브하게 표준 입출력을 키보드로 동작하게 합니다
  - <kbd>-t, --tty</kbd> : 텍스트 기반의 터미널을 에뮬레이션 하게 합니다
```bash
# docker run <options> <image>:<tag>
docker run --rm --name ubuntu -dit ubuntu:20.04
```

* kill : 컨테이너를 종료합니다
```bash
# docker kill <container_name>
docker kill ubuntu
```
<br>


### 3-2. 컨테이너 모니터링

* ps : 실행 중인 컨테이너를 확인합니다
  - <kbd>-a</kbd> : 실행 중이지 않은 컨테이너까지 출력합니다
```bash
docker ps
```

* logs : 컨테이너 로그를 표준 출력으로 보냅니다
  - <kbd>-f</kbd> : 로그를 지속적으로 tailing 합니다
```bash
# docker logs <container_name>
docker logs -f mysql
```

* top : 컨테이너에 떠 있는 프로세스를 확인합니다
```bash
# docker top <container_name> <ps options>
docker ps ubuntu
```
<br>


### 3-3. 컨테이너 상호작용

* cp :  호스트에서 컨테이너로 혹은 반대로 파일을 복사합니다
```bash
# docker cp <container_name>:<path> <host_path> and vice-versa
touch README.md
docker cp ./README.md ubuntu:/home/ubuntu/
```

* exec : 컨테이너 내부에 명령을 실행합니다 
```bash
# docker exec <container_name> <args>
docker exec ubuntu echo 'hello world'
```
<br>


### 3-4. 컨테이너 이미지 생성관리

* images : 현재 로컬에 저장된 이미지 목록을 출력합니다 
```bash
docker images
```

* docker commit : 현재 컨테이너를 별도의 이미지로 저장합니다 
```bash
# docker commit <container_name>:<tag>
docker commit ubuntu:latest
```

* rmi : 해당 이미지를 삭제합니다
```bash
docker rmi ubuntu:latest
```
<br>


### 3-5. 컨테이너 이미지 전송관리

> 본 명령은 dockerhub.com 과 같은 docker registry 계정이 있어야 실습이 가능합니다

* pull : 대상 이미지를 레포지토리에서 로컬로 다운로드합니다
```bash
# docker pull repository[:tag]
docker pull psyoblade/data-engineer-ubuntu:18.04
```

* push : 대상 이미지를 레포지토리로 업로드합니다
```bash
# docker push repository[:tag]
docker push psyoblade/data-engineer-ubuntu:18.04
```

* login : 레지스트리에 로그인 합니다
```bash
docker login
```

* logout : 레지스트리에 로그아웃 합니다
```bash
docker logout
```
<br>


### 3-6. 컨테이너 이미지 빌드

> 별도의 Dockerfile 을 생성하고 해당 이미지를 바탕으로 새로운 이미지를 생성할 수 있습니다

#### 3-6-1. Dockerfile 생성

* Ubuntu:18.04 LTS 이미지를 한 번 빌드하기로 합니다
  - <kbd>FROM image:tag</kbd> : 기반이 되는 이미지와 태그를 명시합니다
  - <kbd>MAINTAINER email</kbd> : 컨테이너 이미지 관리자
  - <kbd>COPY path dst</kbd> : 호스트의 `path` 를 게스트의 `dst`로 복사합니다
  - <kbd>ADD src dst</kbd> : COPY 와 동일하지만 추가 기능 (untar archives 기능, http url 지원)이 있습니다
  - <kbd>RUN args</kbd> : 임의의 명령어를 수행합니다
  - <kbd>USER name</kbd> : 기본 이용자를 지정합니다 (ex_ root, ubuntu)
  - <kbd>WORKDIR path</kbd> : 워킹 디렉토리를 지정합니다
  - <kbd>ENTRYPOINT args</kbd> : 메인 프로그램을 지정합니다
  - <kbd>CMD args</kbd> : 메인 프로그램의 파라메터를 지정합니다
  - <kbd>ENV name value</kbd> : 환경변수를 지정합니다

* 아래와 같이 터미널에서 입력하고
```bash
cat > Dockerfile
```
* 아래의 내용을 복사해서 붙여넣은 다음 <kbd><samp>Ctrl</samp>+<samp>C</samp></kbd> 명령으로 나오면 파일이 생성됩니다
```bash
FROM ubuntu:18.04
LABEL maintainer="park.suhyuk@gmail.com"

RUN apt-get update && apt-get install -y rsync tree

EXPOSE 22 873
CMD ["/bin/bash"]
```

#### 3-6-2. 이미지 빌드

> 위의 이미지를 통해서 베이스라인 우분투 이미지에 rsync 와 tree 가 설치된 새로운 이미지를 생성할 수 있습니다

* 도커 이미지를 빌드합니다
  - <kbd>-f, --file</kbd> : default 는 현재 경로의 Dockerfile 을 이용하지만 별도로 지정할 수 있습니다
  - <kbd>-t, --tag</kbd> : 도커 이미지의 이름과 태그를 지정합니다
  - <kbd>-q, --quiet</kbd> : 빌드 로그의 출력을 하지 않습니다
  - <kbd>.</kbd> : 현재 경로에서 빌드를 합니다 
```bash
# terminal
docker build -t ubuntu:local .
```

<details><summary>[실습] 출력 결과 확인</summary>

> 출력 결과가 오류가 발생하지 않고, 아래와 유사하다면 성공입니다

```bash
Sending build context to Docker daemon  202.8kB
Step 1/5 : FROM ubuntu:18.04
18.04: Pulling from library/ubuntu
e7ae86ffe2df: Pull complete
Digest: sha256:3b8692dc4474d4f6043fae285676699361792ce1828e22b1b57367b5c05457e3
Status: Downloaded newer image for ubuntu:18.04
...
Step 5/5 : CMD ["/bin/bash"]
 ---> Running in 88f12333612b
Removing intermediate container 88f12333612b
 ---> da9a0e997fc0
Successfully built da9a0e997fc0
Successfully tagged ubuntu:local

```

</details>
<br>










## 4. Linux 커맨드라인 명령어 실습


## 5. Hadoop 커맨드라인 명령어 실습


## 6. SQL 명령어 실습

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

