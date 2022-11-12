#!/bin/bash
# cat > env_global.sh

echo "환경변수 출력: $ENV_VAR"

GLOBAL_VAR="global_var"
LOCAL_VAR="local_var_1"

local_func() {
    local LOCAL_VAR="local_var_2"
    echo "글로벌 변수: $GLOBAL_VAR"
    echo "로컬 변수: $LOCAL_VAR"
}

local_func
echo "글로벌 변수: $GLOBAL_VAR"
echo "로컬 변수: $LOCAL_VAR"

export ENV_VAR="modified_env_var"
echo "환경변수 출력: $ENV_VAR"
