#!/bin/bash
# https://yeasy.gitbooks.io/docker_practice/content/install/ubuntu.html

# 卸载旧版本
sudo apt-get remove docker docker-engine docker.io

sudo apt-get update

# 安装可选内核模块包
sudo apt-get install \
        linux-image-extra-$(uname -r) linux-image-extra-virtual
# 添加使用 HTTPS 传输的软件包以及 CA 证书。
sudo apt-get install \
    apt-transport-https ca-certificates curl software-properties-common

# 添加软件源的 GPG 密钥
curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -

# 添加 Docker 软件源
sudo add-apt-repository "deb [arch=amd64] https://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"

# 安装Docker CE

sudo apt-get update
sudo apt-get install docker-ce

# 使用脚本自动安装
# curl -fsSL get.docker.com -o /tmp/get-docker.sh
# sudo sh /tmp/get-docker.sh --mirror Aliyun


# 启动 Docker CE

sudo systemctl enable docker
sudo systemctl start docker


# 建立 docker 用户组
sudo groupadd docker
sudo usermod -aG docker $USER

# sudo sed -i "/ExecStart/c ExecStart=/usr/bin/dockerd –registry-mirror=https://18sjzo7q.mirror.aliyuncs.com -H fd://" \
    # /etc/systemd/system/multi-user.target.wants/docker.service


sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
      "registry-mirrors": ["https://18sjzo7q.mirror.aliyuncs.com"]
}
EOF
sudo systemctl daemon-reload
sudo systemctl restart docker
sudo systemctl status restart docker
