#!/bin/bash

sudo yum -y install git

sudo yum -y install zsh vim epel-release

# development
sudo yum -y groupinstall "Development Tools"  || exit
sudo yum -y install llvm cmake man-pages mercurial || exit

# text
sudo yum  -y install asciidoc


# opengl
sudo yum -y install  mesa-libGL-devel

for file in `cat ~/.dotfiles/lib/centos-list.txt`
do
    sudo yum -y install ${file}
done


