#!/bin/bash
# cat > test07-1.sh

echo -n "오늘은 재택입니까? "
read answer
case $answer in 
    [yY]|[yY][eE][sS]) echo "오늘 하루도 화이팅" ;;
    [nN]|[nN][oO]) echo "출근길 조심하세요" ;;
    *) echo "기타";;
esac
