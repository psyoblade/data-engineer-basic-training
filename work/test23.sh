#!/bin/bash
# test23.sh

set 1 2 3 4
echo "초기 매개변수의 수는 $#"

shift
shift
echo "shift 2회 실행 후 수는 $# -> $@"
