
#!/bin/bash
# cat > test11.sh

total=0
num=0
while [[ $num -lt 10 ]]; do
    num=$(($num+1))
    total=$(($total+$num))
done
echo "1 ~ 10 까지의 합은 $total 입니다" 
