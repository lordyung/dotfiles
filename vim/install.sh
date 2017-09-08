#!/bin/bash
# http://blog.wuxu92.com/z-compile-vim-with-lua-support-in-centos-7/

RELEASE=8.0.0106

if [ ! -f /tmp/function.sh ]; then
    wget http://oijmw20v4.bkt.clouddn.com/FoAhO8bZt6xNA79blwFsN44Eu0_d -O /tmp/function.sh || exit
fi

source /tmp/function.sh || exit

check_is_root

if [ $(check_dist) = "redhat" ]; then
    yum -y install lua-devel luajit-devel ncurses-devel || fail "install lua-devel luajit-devel ncurses-devel fail..."
else
    fail "You System is not support yet."
fi

if [ ! -d $src/vim-$RELEASE ]; then
    info "download vim..."
    wget http://mirrors.ustc.edu.cn/gentoo/distfiles/vim-$RELEASE.tar.gz   -O /tmp/vim-$RELEASE.tar.gz
    tar -xvf  /tmp/vim-$RELEASE.tar.gz -C $src  || exit
fi

cd $src/vim-$RELEASE
make distclean
info "./configure --prefix=$prefix --with-features=huge --with-luajit --enable-luainterp=yes --enable-fail-if-missing"

./configure --prefix=$prefix --with-features=huge --with-luajit --enable-luainterp=yes --enable-fail-if-missing  || exit

make -j4 || exit
success "You already have vim compiled."

make install || exit
make distclean
success "You already have vim installed."


