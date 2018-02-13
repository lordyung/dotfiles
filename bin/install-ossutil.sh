#!/bin/bash

if [ $(uname) = 'Linux' ]; then
    wget http://docs-aliyun.cn-hangzhou.oss.aliyun-inc.com/assets/attach/50452/cn_zh/1493273499823/ossutil -O ~/.bin/ou
elif [ $(uname) = 'Darwin' ];then
    wget http://docs-aliyun.cn-hangzhou.oss.aliyun-inc.com/assets/attach/50452/cn_zh/1493273545151/ossutilmac64 -O ~/.bin/ou
else
    echo "Not support this system." && exit
fi
chmod +x ~/.bin/ou
ou help
