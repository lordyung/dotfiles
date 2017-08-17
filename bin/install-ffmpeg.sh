#!/usr/bin/env bash

prefix=/usr/local

echo "install dependencies..."
yum -y install yasm-devel freetype-devel mercurial cmake autoconf automake gcc gcc-c++ git libtool make nasm pkgconfig zlib-devel || exit

echo "prefix=$prefix"
install_fdkaac() {
if [ ! -f $prefix/lib/pkgconfig/fdk-aac.pc ]; then
    echo "install fdk-aac..."
    if [ ! -d /tmp/fdk-aac ]; then
        wget http://mirrors.ustc.edu.cn/gentoo/distfiles/fdk-aac-0.1.4.tar.gz -O /tmp/fdk-aac-0.1.4.tar.gz
        tar -xvf /tmp/fdk-aac-0.1.4.tar.gz -C /tmp
    fi
    cd /tmp/fdk-aac-0.1.4
    autoreconf -fiv
    ./configure --prefix=$prefix
    make
    make install
    make clean
fi
}
install_lame() {
    echo "install libmp3lame..."
    if [ ! -d /tmp/lame-3.99.5 ]; then
        wget http://mirrors.ustc.edu.cn/gentoo/distfiles/lame-3.99.5.tar.gz || exit
        tar -zxf lame-3.99.5.tar.gz -C /tmp
        rm lame-3.99.5.tar.gz
    fi
    cd /tmp/lame-3.99.5
    ./configure --prefix=$prefix  --enable-nasm
    make
    make install
    make distclean
}
install_x264() {
    echo "install x264..."
    if [ ! -d /tmp/x264-snapshot-20160712-2245 ]; then
        wget http://mirrors.ustc.edu.cn/gentoo/distfiles/x264-snapshot-20160712-2245.tar.bz2 -O /tmp/x264-snapshot-20160712-2245.tar.bz2
        tar -xvf /tmp/x264-snapshot-20160712-2245.tar.bz2 -C /tmp
    fi
    cd /tmp/x264-snapshot-20160712-2245
    ./configure --prefix=$prefix --enable-shared  || exit
    make
    make install
    make distclean
}
install_x265(){
    echo "install x265..."
    if [ ! -d /tmp/x265_2.2 ]; then
        # hg clone https://bitbucket.org/multicoreware/x265  /tmp/x265 || fail "clone x265 fail..."
        wget http://mirrors.ustc.edu.cn/gentoo/distfiles/x265_2.2.tar.gz -O /tmp/x265_2.2.tar.gz
        tar -xvf /tmp/x265_2.2.tar.gz -C /tmp
    fi
    cd /tmp/x265_2.2/build/linux
    cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX=$prefix  -ENABLE_ASSEMBLY:BOOL=OFF ../../source || exit
    make
    make install
    make clean
}
install_libopus() {
    echo "install libops..."
    if [ ! -d /tmp/opus ]; then
        #git clone git://git.opus-codec.org/opus.git /tmp/opus || fail "clone libops fail..."
        wget http://mirrors.ustc.edu.cn/gentoo/distfiles/opus-1.1.tar.gz -O /tmp/opus-1.1.tar.gz
        tar -xvf /tmp/opus-1.1.tar.gz -C /tmp
    fi
    cd /tmp/opus-1.1
    autoreconf -fiv
    ./configure --prefix=$prefix
    make
    make install
    make distclean
}
install_libogg(){
    echo "install libogg..."
    if [ ! -d /tmp/libogg-1.3.2 ]; then
        wget http://mirrors.ustc.edu.cn/gentoo/distfiles/libogg-1.3.2.tar.xz -O /tmp/libogg-1.3.2.tar.xz || exit
        tar -xvf /tmp/libogg-1.3.2.tar.xz -C /tmp
    fi
    cd /tmp/libogg-1.3.2
    ./configure --prefix=$prefix
    make
    make install
    make distclean

}
install_libvorbis(){
    echo "install libvorbis..."
    if [ ! -d /tmp/libvorbis-1.3.4 ]; then
        wget http://mirrors.ustc.edu.cn/gentoo/distfiles/libvorbis-1.3.5.tar.xz -O /tmp/libvorbis-1.3.5.tar.xz || exit
        tar -xvf /tmp/libvorbis-1.3.5.tar.xz -C /tmp
        rm libvorbis-1.3.5.tar.xz
    fi
    cd /tmp/libvorbis-1.3.5
    ./configure --prefix=$prefix --with-ogg=$prefix
    make
    make install
    make distclean
}
install_libvpx(){
    echo "install libvpx..."
    if [ ! -d /tmp/libvpx-1.6.0 ]; then
        # git clone --depth 1 https://chromium.googlesource.com/webm/libvpx.git /tmp/libvpx || fail "clone libvpx fail..."
        wget http://mirrors.ustc.edu.cn/gentoo/distfiles/libvpx-1.6.0.tar.bz2 -O /tmp/libvpx-1.6.0.tar.bz2 || exit
        tar -xvf /tmp/libvpx-1.6.0.tar.bz2 -C /tmp
    fi
    cd /tmp/libvpx-1.6.0
    ./configure --prefix=$prefix
    make -j8
    make install
    make clean
}
compile_ffmpeg(){
    if [ ! -d /tmp/ffmpeg-3.2.2 ]; then
        wget http://mirrors.ustc.edu.cn/gentoo/distfiles/ffmpeg-3.2.2.tar.bz2 -O /tmp/ffmpeg-3.2.2.tar.bz2
        tar -xvf /tmp/ffmpeg-3.2.2.tar.bz2 -C /tmp
    fi

    echo "compile ffmpeg..."
    cd /tmp/ffmpeg-3.2.2
    PKG_CONFIG_PATH=$prefix/lib/pkgconfig \
        ./configure --prefix=$prefix \
        --extra-cflags=-I$prefix/include \
        --extra-ldflags=-L$prefix/lib \
        --pkg-config-flags=--static \
        --enable-gpl \
        --enable-nonfree \
        --enable-libfdk_aac \
        --enable-libfreetype \
        --enable-libmp3lame \
        --enable-libopus \
        --enable-libvorbis \
        --enable-libvpx \
        --enable-libx264 \
        --enable-libx265 \
        --enable-ffplay \
        --enable-sdl2 \
        || exit

    make  -j32 || exit

    success "You already have ffmpeg compiled."
    hash -r

    make install
    #make distclean
    success "You already have ffmpeg installed."
}
install_fdkaac
install_lame
install_x264
install_x265
install_libopus
install_libogg
install_libvorbis
install_libvpx
compile_ffmpeg
