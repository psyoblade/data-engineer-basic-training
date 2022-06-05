#!/bin/bash

sleep_secs=$1
running_times=$2
silence=$3

if [ $# -lt 3 ]; then
    echo "./$0 [sleep_secs] [running_times] [silence]"
    echo "./$0 1 600 true"
    exit 1
fi

total_secs=$((${sleep_secs} * ${running_times}))
elapsed_secs=0

echo "$sleep_secs 초 슬립 후, 로그 출력을 $running_times 회 반복"
echo

for x in $(seq 1 $running_times); do
    sleep $sleep_secs
    elapsed_secs=$((${elapsed_secs} + ${sleep_secs}))
    if [[ $silence != "true" ]]; then
        echo "${elapsed_secs} 초 지났습니다"
        echo
    fi
done
