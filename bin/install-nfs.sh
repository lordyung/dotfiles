#!/bin/bash

if [ $(check_distro) = "Ubuntu" ]; then
    sudo apt-get install -y nfs-kernel-server || exit
elif [ $(check_distro) = "RedHat" ]; then
    sudo yum -y install nfs-utils || exit
else
    echo "Don't Support this System." && exit
fi


read -p "请输入要映射的目录(多个目录用空格分开): " directory
echo  "# nfs-server configure" | sudo tee  /etc/exports
for file in $directory
do
    echo $file
    if [ ! -d $file ]; then
        echo "$file is not exist, ignore..."
    else
        if [ ${file:0:1}  != "/" ]; then
            file=$PWD/$file
        fi
        echo "$file  *(rw,async,no_root_squash,no_subtree_check)"  | sudo tee -a /etc/exports
    fi
done
sudo exportfs -a

sudo systemctl enable nfs-server.service
sudo systemctl restart nfs-server.service
sudo systemctl status nfs-server.service
showmount -e
