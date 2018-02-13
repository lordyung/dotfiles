#!/bin/bash

wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocksR.sh -O /tmp/shadowsocksR.sh
chmod +x /tmp/shadowsocksR.sh
/tmp/shadowsocksR.sh 2>&1 | tee shadowsocksR.log
