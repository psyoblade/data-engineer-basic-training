#!/bin/bash
# cat > test15.sh

# function say_hello() { ... }     # 이러한 포맷을 가지면 함수로 인식합니다 function 은 없어도 됩니다

say_hello() {                      # 함수의 매개변수는 $1 ~ $N 통해서 처리가 가능합니다
    arg1=$1
    arg2=$2
    echo $arg1 $arg2
    if [ $# -gt 0 ]; then          # return 은 하나의 숫자 매개변수를 가지는 종료 코드를 반환하는 명령입니다
    	return 0                   # 함수의 반환값은 성공(0), 실패(!0)를 나타내는 숫자만 가능합니다
  	else
    	return 1
  	fi
}

say_hello "arg1" "arg2"
if [ $? -ne 0 ]; then
    echo "매개변수는 1개 이상이어야 합니다"
else
    echo "좋은 하루 되세요"
fi
