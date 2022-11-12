#!/bin/bash
# cat > test13.sh

touch foo
rm -f bar
if [ -f foo ] && [ ! -f bar ]; then
    echo "OK"
fi
rm -f foo
