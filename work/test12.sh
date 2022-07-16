#!/bin/bash
# cat > test12.sh

total=0
num=0
until [[ $num -ge 10 ]]; do
    num=$(($num+1))
    total=$(($total+$num))
done
echo "$total"
