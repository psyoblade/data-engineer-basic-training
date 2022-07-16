#!/bin/bash
# cat > test25.sh

foo="helloworld"
declare | grep helloworld | wc -l

unset foo
declare | grep helloworld | wc -l
