#Nginxbuild
Bash script I'm using on my VPS to build Nginx with the following modules:
* PageSpeed - https://github.com/pagespeed/ngx_pagespeed
* HeadersMore - https://github.com/openresty/headers-more-nginx-module

##Requirements
Should work with any Linux distro with standard build tools installed.  
Tested on Ubuntu 16.04.

##Usage
Change the variables in the first few lines as new versions of software are released.  
```
## Set some variables
DIRECTORY=/usr/local/src
PAGESPEED_VERSION=1.11.33.3
HEADERS_VERSION=0.31
NGINX_VERSION=1.11.3
```
