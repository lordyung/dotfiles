#!/bin/bash
# https://github.com/ranger/ranger

hash ranger 2>/dev/null || {
    echo "Cloning ranger..."
    rm -rf /tmp/ranger || exit
    git clone --depth 1 https://github.com/ranger/ranger /tmp/ranger
# compile
cd /tmp/ranger
sudo make install
}

ranger
