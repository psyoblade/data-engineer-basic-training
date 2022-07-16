#!/bin/bash
# cat > test07.sh

echo -n "오늘은 재택입니까? "
read answer
case $answer in 
    yes) echo "오늘 하루도 화이팅" ;;
    no) echo "출근길 조심하세요" ;;
    *) echo "기타";;
esac
