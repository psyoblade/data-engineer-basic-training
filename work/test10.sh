#!/bin/bash
# cat > test10.sh

echo -n "패스워드를 입력하세요: "
read password

while [[ $password != "password" ]]; do
    echo "잘못된 패스워드입니다 $password"
    echo -n "패스워드를 입력하세요: "
    read password
done

echo "로그인하였습니다"
