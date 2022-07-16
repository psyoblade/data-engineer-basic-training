#!/bin/bash

#!/bin/bash
if [ $# -ne 2 ]; then
    echo "파라메터를 확인하세요"
    echo "./test05.sh num"
fi

if [ $1 -eq 0 ]; then
    echo "0"
elif [ $1 -gt 0 ]; then
    echo "양수"
else
    echo "음수"
fi
