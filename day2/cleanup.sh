#!/bin/bash
# clean up temporary files

echo "rm -r tmp/source/*"
rm -r tmp/source/*

echo "rm -r tmp/target/*"
rm -r tmp/target/*

tree tmp
