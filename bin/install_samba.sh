#!/bin/sh
# install samba
sudo apt-get install  -y samba

# add samba user
sudo smbpasswd -a $USER

## configure samba

cat | sudo tee  /etc/samba/smb.conf << EOF
[global]
    display charset=UTF-8
    unix charset=UTF-8
    security=user

[data]
    path=/mnt/data
    #public=yes
    writable=yes
    #readonly=yes
    valid users=lordyung
    create mask=0600
    directory mask=0700
    available=yes
    browseable=yes
EOF

testparm
