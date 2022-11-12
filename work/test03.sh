#!/bin/bash
# cat > test03.sh                  # 입력 매개변수를 셸 스크립트 내에서 활용할 수 있습니다

echo filename is $0
echo first argument is $1
echo second argument is $2

# 셸 매개변수 동작
echo argument length is $#
echo all arguemnts are "$*"        # IFS 첫 번째 값을 구분자로 하나의 변수로 표현
echo all arguemnts are "$@"        # IFS 와 무관하게 매개변수를 표현

# 매개변수 사용
shift
echo shifting argument $1
echo process id is $$
echo parent process id is $PPID
