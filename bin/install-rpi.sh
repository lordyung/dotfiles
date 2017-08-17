#!/bin/bash

# 1. format sdcard
# wget -c http://vx2-downloads.raspberrypi.org/raspbian_lite/images/raspbian_lite-2016-11-29/2016-11-25-raspbian-jessie-lite.zip
# unzip 2016-11-25-raspbian-jessie-lite.zip
# dd bs=1m if=2016-11-25-raspbian-jessie-lite.img of=/dev/xxxx


# 2. change passwd
# passwd pi
# passwd root
# passwd --unlock root


# 3. change sources.list
# sh -c "echo 127.0.0.1 localhost >> /etc/hosts"

bash -c "cat << EOF> /etc/apt/sources.list
# http://www.raspbian.org/RaspbianMirrors
deb http://mirrors.ustc.edu.cn/raspbian/raspbian jessie main contrib non-free rpi
deb http://mirrors.aliyun.com/raspbian/raspbian/ wheezy main non-free contrib
deb-src http://mirrors.aliyun.com/raspbian/raspbian/ wheezy main non-free contrib
EOF"


# 4. setup network

tee /etc/network/interfaces > /dev/null <<'EOF'
# Include files from /etc/network/interfaces.d:
source-directory /etc/network/interfaces.d

auto lo
iface lo inet loopback

auto eth0
iface eth0 inet dhcp
#iface eth0 inet static
address 192.168.10.32
netmask 255.255.255.0
gateway 192.168.10.1
dns-nameservers 223.5.5.5

auto wlan0
allow-hotplug wlan0
iface wlan0 inet static
# iface wlan0 inet dhcp
address 192.168.10.72
netmask 255.255.255.0
gateway 192.168.10.1
wpa-conf /etc/wpa_supplicant/wpa_supplicant.conf
dns-nameservers 223.5.5.5
EOF

tee /etc/wpa_supplicant/wpa_supplicant.conf  > /dev/null <<'EOF'

country=GB
ctrl_interface=DIR=/var/run/wpa_supplicant GROUP=netdev
update_config=1

network={
ssid="lordyung"
key_mgmt=WPA-PSK
psk="jiejin264"
}

network={
ssid="Chinanet-YF"
key_mgmt=WPA-PSK
psk="thtfityfwifi2015"
}
EOF
# change locale.gen
sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/1' /etc/locale.gen
sed -i 's/# zh_CN.UTF-8 UTF-8/zh_CN.UTF-8 UTF-8/1' /etc/locale.gen
# locale-gen


# change hostname
echo "rpi" | tee /etc/hostname > /dev/null
sed -i 's/raspberrypi/rpi/1' /etc/hosts
