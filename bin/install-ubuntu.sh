#!/bin/bash
sudo sed -i 's/cn.archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
sudo sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
sudo apt-get update
sudo apt-get install -y git vim zsh tmux wget curl tree cscope exuberant-ctags
sudo apt-get install -y make cmake gcc g++ lib32ncurses5-dev zlib1g-dev libssl-dev patch gawk unzip
sudo apt-get install -y openssh-server nginx

sudo apt-get install build-essential libgl1-mesa-dev
