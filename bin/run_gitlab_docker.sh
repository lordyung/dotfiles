#!/bin/bash
set -e

cid=$(docker ps -a | grep 'gitlab/gitlab-ce'| awk '{print $1}')

if [ -n "$cid"  ]; then
    docker stop $cid
    docker rm $cid
fi

# EXPOSE 443 80 22
sudo docker run --detach \
    --hostname 192.168.0.71 \
    --publish 8443:443 --publish 88:80 --publish 2222:22 \
    --name gitlab \
    --restart always \
    -v /var/gitlab/config:/etc/gitlab \
    -v /var/gitlab/logs:/var/log/gitlab \
    -v /var/gitlab/data:/var/opt/gitlab \
    gitlab/gitlab-ce

