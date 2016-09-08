#!/bin/bash

## This script should be run as root, since it's compiling software from source

## Set some variables
DIRECTORY=/usr/local/src
PAGESPEED_VERSION=1.11.33.3
HEADERS_VERSION=0.31
NGINX_VERSION=1.11.3

## create group and user
addgroup www-data
useradd -c www-data -d /var/www -M -g www-data -s /usr/sbin/nologin www-data

## Get PageSpeed
cd ${DIRECTORY}
wget https://github.com/pagespeed/ngx_pagespeed/archive/release-${PAGESPEED_VERSION}-beta.zip
unzip release-${PAGESPEED_VERSION}-beta.zip
rm release-${PAGESPEED_VERSION}-beta.zip
cd ngx_pagespeed-release-${PAGESPEED_VERSION}-beta/
wget https://dl.google.com/dl/page-speed/psol/${PAGESPEED_VERSION}.tar.gz
tar -xzvf ${PAGESPEED_VERSION}.tar.gz
rm ${PAGESPEED_VERSION}.tar.gz

## Get HeadersMore
cd ${DIRECTORY}
wget https://github.com/openresty/headers-more-nginx-module/archive/v${HEADERS_VERSION}.tar.gz
tar -xvzf v${HEADERS_VERSION}.tar.gz
rm v${HEADERS_VERSION}.tar.gz

## Get Nginx
cd ${DIRECTORY}
wget https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz
tar -xvzf nginx-${NGINX_VERSION}.tar.gz
rm nginx-${NGINX_VERSION}.tar.gz

cd nginx-${NGINX_VERSION}/
     ./configure --sbin-path=/usr/sbin/nginx \
     --conf-path=/etc/nginx/nginx.conf \
     --http-log-path=/var/log/nginx/access.log \
     --error-log-path=/var/log/nginx/error.log \
     --lock-path=/var/lock/nginx.lock \
     --pid-path=/run/nginx.pid \
     --user=www-data \
     --group=www-data \
     --http-client-body-temp-path=/var/lib/nginx/body \
     --http-fastcgi-temp-path=/var/lib/nginx/fastcgi \
     --http-proxy-temp-path=/var/lib/nginx/proxy \
     --http-scgi-temp-path=/var/lib/nginx/scgi \
     --http-uwsgi-temp-path=/var/lib/nginx/uwsgi \
     --with-debug \
     --with-pcre-jit \
     --with-ipv6 \
     --with-http_ssl_module \
     --with-http_stub_status_module \
     --with-http_realip_module \
     --with-http_auth_request_module \
     --with-http_addition_module \
     --with-http_dav_module \
     --with-http_flv_module \
     --with-http_geoip_module \
     --with-http_gunzip_module \
     --with-http_gzip_static_module \
     --with-http_image_filter_module \
     --with-http_mp4_module \
     --with-http_perl_module \
     --with-http_random_index_module \
     --with-http_secure_link_module \
     --with-http_v2_module \
     --with-http_sub_module \
     --with-http_xslt_module \
     --with-mail \
     --with-mail_ssl_module \
     --with-stream \
     --with-stream_ssl_module \
     --with-threads \
     --add-module=${DIRECTORY}/headers-more-nginx-module-${HEADERS_VERSION} \
     --add-module=${DIRECTORY}/ngx_pagespeed-release-${PAGESPEED_VERSION}-beta

make
make install

echo ""
echo "If there are no errors, the build is completed"
echo "Use the link below to add an init file for Nginx"
echo "https://www.nginx.com/resources/wiki/start/topics/examples/initscripts/"
