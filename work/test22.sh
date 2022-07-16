#!/bin/bash
# cat > test22.sh

echo "초기 매개변수의 수는 $#"

set $(date +'%Y%m%d')
echo "Set 이후에는 $#"

shift
echo "Shift 이후에는 $#"
