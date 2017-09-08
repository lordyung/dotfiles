#!/bin/bash

if [ ! -f /tmp/function.sh ]; then
    wget http://oijmw20v4.bkt.clouddn.com/FoAhO8bZt6xNA79blwFsN44Eu0_d -O /tmp/function.sh || exit
fi

source /tmp/function.sh || exit

if [ $(check_dist) = "redhat" ];then
    yum -y install libevent-devel ncurses-devel || fail "install libevent-devel ncurses-devel fail..."
elif [ $(check_dist) = "debian" ]; then
    apt-get install libevent-dev ncurses-dev || fail "install libevent-devel ncurses-devel fail..."
fi

if [ ! -d $src/tmux-2.3 ]; then
    wget http://mirrors.ustc.edu.cn/gentoo/distfiles/tmux-2.3.tar.gz -O /tmp/tmux-2.3.tar.gz || exit
    tar -xvf /tmp/tmux-2.3.tar.gz -C $src || exit
fi

cd $src/tmux-2.3
autoreconf -fi

info "./configure --prefix=$prefix"
./configure --prefix=$prefix || exit

make -j4 || exit
success "You already have tmux compiled."

make install || exit
make distclean
success "You already have tmux installed."

