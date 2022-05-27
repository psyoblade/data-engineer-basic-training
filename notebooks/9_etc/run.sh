#!/bin/bash

export HADOOP_HOME="/usr/local/hadoop-2.7.4"
export JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64"
export ARROW_LIBHDFS_DIR="$HADOOP_HOME/lib/native"

for jar in `find $HADOOP_HOME/share -regex ".*jar$"`; do
    export CLASSPATH=$CLASSPATH:$jar
done
python ./1.py
