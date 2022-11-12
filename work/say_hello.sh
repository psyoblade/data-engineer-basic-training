#!/bin/bash
# cat > say_hello.sh

say_hello() {
    echo "안녕하세요"
}

for x in $(seq 1 5); do 
    say_hello
done
