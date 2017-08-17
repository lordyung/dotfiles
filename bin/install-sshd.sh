#!/bin/bash

if [ $(check_distro) = 'Ubuntu' ]; then
    sudo apt-get install -y openssh-server
elif  [ $(check_distro) = 'RedHat' ]; then
    sudo yum install -y openssh-server
    # 将端口2222加入防火墙
    sudo firewall-cmd --zone=public --permanent --add-port=2222/tcp
    sudo firewall-cmd --reload
    sudo firewall-cmd --list-all
    sudo systemctl status firewalld
elif  [ $(check_distro) = 'Darwin' ]; then
    brew install openssh
fi


# 更改端口号为2222
# sudo sed -i '/Port /d' /etc/ssh/sshd_config
# sudo sed -i '$a\Port 2222' /etc/ssh/sshd_config

# 禁止root登录
sudo sed -i '/PermitRootLogin/d' /etc/ssh/sshd_config
sudo sed -i '$a\PermitRootLogin no' /etc/ssh/sshd_config

sudo systemctl restart sshd
sudo systemctl status sshd
