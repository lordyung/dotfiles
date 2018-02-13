#!/bin/bash
set -e
# https://yeasy.gitbooks.io/docker_practice/content/install/ubuntu.html

# 卸载旧版本
apt-get -y remove docker docker-engine docker.io

apt-get -y update

# 安装可选内核模块包
apt-get -y install \
        linux-image-extra-$(uname -r) linux-image-extra-virtual
# 添加使用 HTTPS 传输的软件包以及 CA 证书。
apt-get -y install \
    apt-transport-https ca-certificates curl software-properties-common

# 添加软件源的 GPG 密钥
curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | apt-key add -

# 添加 Docker 软件源
add-apt-repository "deb [arch=amd64] https://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"

# 安装Docker CE

apt-get -y update
apt-get -y install docker-ce

# 使用脚本自动安装
# curl -fsSL get.docker.com -o /tmp/get-docker.sh
# sh /tmp/get-docker.sh --mirror Aliyun


# 启动 Docker CE

systemctl enable docker
systemctl start docker


# 建立 docker 用户组
groupadd docker
usermod -aG docker $USER

# sed -i "/ExecStart/c ExecStart=/usr/bin/dockerd –registry-mirror=https://18sjzo7q.mirror.aliyuncs.com -H fd://" \
    # /etc/systemd/system/multi-user.target.wants/docker.service


mkdir -p /etc/docker
tee /etc/docker/daemon.json <<-'EOF'
{
      "registry-mirrors": ["https://18sjzo7q.mirror.aliyuncs.com"]
}
EOF


systemctl daemon-reload
systemctl restart docker
systemctl status restart docker
