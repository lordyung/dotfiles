#!/bin/bash
qshell listbucket book /tmp/.book_list

for file in `ls`
do
    grep $file /tmp/.book_list > /dev/null || qp book ${file}
done
