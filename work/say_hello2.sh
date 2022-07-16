#!/bin/bash
# cat > say_hello2.sh

say_hello2() {
    name=$1
    echo "안녕하세요 $name 님"
}

echo -n "이름을 입력하세요: "
read name
say_hello2 $name
