#!/bin/bash
# cat > say_hello3.sh

say_hello3() {
    if [ $# -lt 1 ]; then
        return 1
    else
        echo "매개변수는 $1 입니다"
    fi
}

say_hello3 "안녕"
say_hello3
if [ $? -eq 0 ]; then
    echo "좋은 하루입니다"
else
    echo "매개변수를 하나 이상 입력하세요"
fi

if say_hello3 "안녕"; then
    echo "좋은 하루입니다"
else
    echo "매개변수를 하나 이상 입력하세요"
fi

if say_hello3 ; then
    echo "좋은 하루입니다"
else
    echo "매개변수를 하나 이상 입력하세요"
fi
