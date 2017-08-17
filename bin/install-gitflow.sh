#!/bin/bash

hash git-flow 2>/dev/null || {

wget https://code.aliyun.com/dist/src/raw/master/gitflow.tar.gz -O /tmp/gitflow.tar.gz

tar -xf /tmp/gitflow.tar.gz -C /tmp

cd /tmp/gitflow-avh

git checkout .

sudo make install

}
