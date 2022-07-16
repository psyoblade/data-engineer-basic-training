#!/bin/bash
# cat > test02.sh                 # 모든 변수는 문자열로 간주하여 수행됩니다

one_plus_two=1+2
echo "$one_plus_two"              # 큰따옴표는 변수 표현식을 값으로 변경
echo '$one_plus_two'              # 작은따옴표는 아무런 변화가 없음
