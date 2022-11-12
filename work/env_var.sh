#!/bin/bash
# cat > env_var.sh

# 환경변수
export ENV_VAR="env_var"           # 선언된 셸 내에서 실행되는 모든 셸과 공유하는 변수

# 전역변수
GLOBAL_VAR="global_var"            # 실행되는 셸 파일 내에서 어디서든 접근 가능한 변수

# 지역변수
function say_hello() {
    local LOCAL_VAR="local_var"    # 실행되는 함수 내에서만 접근 가능한 함수
}

say_hello
