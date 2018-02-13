#!/bin/bash
set -e

cid=$(docker ps -a | grep gerrit| awk '{print $1}')

if [ -n "$cid"  ]; then
    docker stop $cid
    docker rm $cid
fi

rm -rf /var/gerrit/review_site/*

password_file=/etc/nginx/gerrit_password

if [ ! -f $password_file ]; then
    touch $password_file
fi

htpasswd -bm $password_file citybrand citybrand200903
htpasswd -bm $password_file gerrit grjiejin264
htpasswd -bm $password_file hebc hebc4321
htpasswd -bm $password_file jason jason4321
htpasswd -bm $password_file joo joo4321
htpasswd -bm $password_file leo leo4321
htpasswd -bm $password_file lordyung jiejin264
htpasswd -bm $password_file rediron rediron4321
htpasswd -bm $password_file sam sam4321
htpasswd -bm $password_file sugar sugar4321
htpasswd -bm $password_file tyson jiejin264

docker run -d -p 8080:8080 -p 29418:29418 \
    --name gerrit \
    --restart=always \
    -v /var/gerrit/review_site:/var/gerrit/review_site \
    -e AUTH_TYPE=HTTP \
    -e WEBURL=http://192.168.0.71/ \
    -e GITWEB_TYPE=gitiles \
    -e SMTP_SERVER=smtp.citybrandhk.com \
    -e SMTP_SERVER_PORT=465 \
    -e SMTP_ENCRYPTION=ssl \
    -e SMTP_USER=tyson.zhang@citybrandhk.com \
    -e SMTP_PASS=Cbjiejin264 \
    -e SMTP_CONNECT_TIMEOUT=10sec \
    -e SMTP_FROM=tyson.zhang@citybrandhk.com \
    -e GERRIT_INIT_ARGS='--install-plugin=download-commands' registry.cn-shenzhen.aliyuncs.com/lordyung/gerrit

 # commit-message-length-validator.jar  download-commands.jar  hooks.jar  replication.jar  reviewnotes.jar  singleusergroup.jar
