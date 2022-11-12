#!/bin/bash

for x in $(seq 1 10); do
    if [ $(($x%2)) -eq 0 ]; then
        echo $x
    fi
done
