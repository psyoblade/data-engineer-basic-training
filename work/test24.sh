#!/bin/bash
# cat > test24.sh                     # trap 명령을 통해서 signal 처리를 합니다

# 실습1) 실행 도중에 인터럽트(Ctrl+C)를 해도 임시 파일을 삭제후 종료하는 스크립트를 생성합니다
tmp_file="/tmp/my_tmp_file_$$"

# 인터럽트 되었을 때에 생성 중인 임시파일 제거 후 정상적으로 다음 프로그램 실행
trap "rm -rf $tmp_file" INT

file_check() {
    echo "작업 파일을 생성 합니다 - $tmp_file ..."
    date > $tmp_file

    echo "인터럽트 명령(Ctrl+C)으로 종료할 수 있습니다"
    while [[ -f $tmp_file ]]; do
        echo "작업을 수행 중입니다"
        sleep 1
    done
}

file_check

echo "임시 파일이 모두 삭제 되었습니다"
ls $tmp_file
exit 0
