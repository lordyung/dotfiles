#!/bin/bash
qshell listbucket distfiles /tmp/.distfiles

for file in `ls *.tar.gz *.tar.xz *.tar.bz2 *.zip`
do
    grep $file /tmp/.distfiles > /dev/null || qp ${file}
done
