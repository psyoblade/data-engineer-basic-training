#!/usr/bin/env python

from pyarrow import fs
hdfs = fs.HadoopFileSystem("namenode", 8020)
info = hdfs.get_file_info(fs.FileSelector("/", recursive=True))
print(info)
