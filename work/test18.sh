#!/bin/bash
# cat > test18.sh

this_year=2022
dollar='$'
string='this_year'
eval out=$dollar$string            # $this_year 출력을 위해서 $ 와 this_year 변수를 eval 합니다
echo $out
