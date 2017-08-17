#!/bin/bash
# https://www.liquidweb.com/kb/how-to-install-and-configure-vsftpd-on-centos-7/
# http://pcvc.net/blog/2015/08/09/centos-7-installation-configuration-do-vsftpd-ftp-service/
# Step 1: Install vsftpd

# Make sure only root can run our script

if [ `uname` = 'Linux' ];then
    if [ -f /etc/debian_version ]; then
        sudo apt-get install -y vsftpd
    elif [ -f /etc/redhat-release ]; then
        sudo yum -y update
        sudo yum -y install vsftpd

        # Step 2: Configure vsftpd
        # vim /etc/vsftpd/vsftpd.conf
        # anonymous_enable=NO
        # Allow local uses to login by changing the local_enable setting to YES:
        # local_enable=YES
        # If you want local user to be able to write to a directory, then change the write_enable setting to YES:
        # write_enable=YES
        # #Local users will be ‘chroot jailed’ and they will be denied access to any other part of the server; change the chroot_local_user setting to YES:
        # chroot_local_user=YES


        # Allow vsftpd Through the Firewall
        # Allow the default FTP port, port 21, through firewalld:

        sudo firewall-cmd --permanent --add-port=21/tcp

        # And reload the firewall:
        sudo firewall-cmd --reload
    fi
    sudo systemctl restart vsftpd
    # Then set the vsftpd service to start at boot:
    sudo systemctl enable vsftpd
    sudo systemctl status vsftpd

elif [ `uname` = 'Darwin' ]; then
    brew install vsftpd
else
    echo "Don't Support this system yet." && exit 1
fi
