#!/bin/bash
# cat > test20.sh

exit 0                             # 스크립트 종료시에 성공여부는 결과값($?)을 통해 알 수 있습니다

# 에러코드
# 126     : 실행 가능한 파일이 아닙니다
# 127     : 명령을 찾을 수 없습니다
# 128 이상 : 신호(signal)가 발생       # 128 + Signal - ex_ SIGKILL(9) 128 + 9 ExitCode 137
