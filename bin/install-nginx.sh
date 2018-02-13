#!/bin/bash

if [ $(check_distro) = "Ubuntu" ]; then
    sudo apt-get install -y nginx || exit
elif [ $(check_distro) = "RedHat" ]; then
    sudo yum -y install nginx || exit

    sudo systemctl start firewalld || exit  # configure firewall
    sudo firewall-cmd --zone=public  --permanent --add-service=http
    sudo firewall-cmd --reload
    sudo firewall-cmd --list-all
    sudo systemctl status firewalld
else
    echo "Don't Support this System." && exit
fi

sudo mkdir -p /usr/local/var/www

#cp $HOME/.nginx/nginx.conf /etc/nginx.conf

sudo systemctl enable nginx
sudo systemctl restart nginx
sudo systemctl status nginx

exit

# from source
test -f /tmp/function.sh || wget http://oijmw20v4.bkt.clouddn.com/function.sh -O /tmp/function.sh
source /tmp/function.sh
src=$prefix/src
prefix=/usr/local

if [ $(check_dist) = "redhat" ]; then
    yum install GeoIP-devel gd-devel gperftools-devel libxml2-devel libxslt-devel perl-ExtUtils-Embed
elif [ $(check_dist) = "debian" ]; then
    echo
else
    fail  "You System is not support yet."
fi

if [ ! -d $src/nginx-1.11.6 ]; then
wget http://mirrors.ustc.edu.cn/gentoo/distfiles/nginx-1.11.6.tar.gz -O /tmp/nginx-1.11.6.tar.gz
tar -xvf /tmp/nginx-1.11.6.tar.gz -C $src
fi

cd $src/nginx-1.11.6
info "cd $src/nginx-1.11.6"

info "./configure --prefix=$prefix/nginx"
# --prefix=$prefix/nginx \
    # --sbin-path=/usr/local/sbin/nginx \
    # --conf-path=/usr/local/etc/nginx/nginx.conf \
    # --modules-path=/usr/local/lib \
    # --pid-path=/run/nginx.pid \
    # --with-http_ssl_module
./configure --prefix=/usr/local/share/nginx \
    --sbin-path=$preifx/sbin/nginx \
    --modules-path=$prefix/lib/nginx \
    --conf-path=$prefix/etc/nginx/nginx.conf \
    --error-log-path=/var/log/nginx/error.log \
    --http-log-path=/var/log/nginx/access.log \
    --http-client-body-temp-path=/var/lib/nginx/tmp/client_body \
    --http-proxy-temp-path=/var/lib/nginx/tmp/proxy \
    --http-fastcgi-temp-path=/var/lib/nginx/tmp/fastcgi \
    --http-uwsgi-temp-path=/var/lib/nginx/tmp/uwsgi \
    --http-scgi-temp-path=/var/lib/nginx/tmp/scgi \
    --pid-path=/run/nginx.pid \
    --lock-path=/run/lock/subsys/nginx \
    --user=nginx \
    --group=nginx \
    --with-file-aio \
    --with-http_ssl_module \
    --with-http_v2_module \
    --with-http_realip_module \
    --with-http_addition_module \
    --with-http_xslt_module=dynamic \
    --with-http_image_filter_module=dynamic \
    --with-http_geoip_module=dynamic \
    --with-http_sub_module \
    --with-http_dav_module \
    --with-http_flv_module \
    --with-http_mp4_module \
    --with-http_gunzip_module \
    --with-http_gzip_static_module \
    --with-http_random_index_module \
    --with-http_secure_link_module \
    --with-http_degradation_module \
    --with-http_slice_module \
    --with-http_stub_status_module \
    --with-http_perl_module=dynamic \
    --with-mail=dynamic \
    --with-mail_ssl_module \
    --with-pcre \
    --with-pcre-jit \
    --with-stream=dynamic \
    --with-stream_ssl_module \
    --with-google_perftools_module \
    --with-debug
make -j4
make install
