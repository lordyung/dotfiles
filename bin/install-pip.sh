#!/bin/sh
# 安装pip

if [ $(check_distro) = 'Ubuntu' ]; then
    sudo apt-get -y install python-pip
elif [ $(check_distro) = 'ReadHat' ];then
    sudo yum install -y python-pip
elif [ $(check_distro) = 'Darwin' ]; then
    brew install python
else
    echo "Don't Support the system."  && exit
fi

sudo pip install -U  pip

