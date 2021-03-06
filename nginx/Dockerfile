#jmorille/nginx

FROM debian:latest

# Set correct environment variables.
# Set the env variable DEBIAN_FRONTEND to noninteractive
ENV HOME="/root" DEBIAN_FRONTEND="noninteractive"



# Config proxy env
# #######################
# ENV http_proxy="http://proxy:3128"  no_proxy=""
# HTTP_PROXY="$http_proxy" https_proxy="$http_proxy" HTTPS_PROXY="$http_proxy" NO_PROXY="$no_proxy"



# #######################
# Install  NGINX
# #######################
ENV NGINX_VERSION="1.11.3"  NPS_VERSION="1.11.33.2"

# Expose
# #######################
EXPOSE 80 443
VOLUME ["/data/html", "/var/log/nginx", "/var/lib/nginx", "/data/cert" ]


# Install dependencies
# #######################
RUN apt-get update -qq && \
    apt-get install -yqq --force-yes  --fix-missing \
       apt-utils \
       build-essential \
       wget zip \
       openssl ca-certificates \
       zlib1g-dev \
       libpcre3 libpcre3-dev libssl-dev libperl-dev



# From instructions here: https://github.com/pagespeed/ngx_pagespeed
# Download ngx_pagespeed
# RUN cd /tmp && wget -q -O - https://github.com/pagespeed/ngx_pagespeed/archive/v$NPS_VERSION-beta.tar.gz | tar zxf -  && \
#  cd /tmp/ngx_pagespeed-$NPS_VERSION-beta/ && wget -q -O - https://dl.google.com/dl/page-speed/psol/${NPS_VERSION}.tar.gz | tar zxf -
# In build : --add-module=/tmp/ngx_pagespeed-$NPS_VERSION-beta

# Download Geoip data
# #######################
# RUN mkdir /data/geoip && \
#     wget -q -O - http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz | gunzip  > /data/geoip/GeoIP.dat && \
#     wget -q -O - http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz | gunzip  > /data/geoip/GeoLiteCity.dat
# In build :  --with-http_geoip_module

# Download and build nginx
# #######################
# Modules :  http://wiki.nginx.org/Modules
RUN mkdir -p /data && \
    mkdir -p /var/lib && \
    cd /tmp && \
    wget -q -O - http://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz | tar zxf -

# Secure Ngnix version
# #######################
# http://www.cyberciti.biz/tips/linux-unix-bsd-nginx-webserver-security.html
RUN sed -i'' 's/static char ngx_http_server_string\[\] = "Server: nginx" CRLF;/static char ngx_http_server_string\[\] = "Server: Microsoft-IIS\/7\.5" CRLF;/' /tmp/nginx-${NGINX_VERSION}/src/http/ngx_http_header_filter_module.c \
&&  sed -i'' 's/static char ngx_http_server_full_string\[\] = "Server: " NGINX_VER CRLF;/static char ngx_http_server_full_string\[\] = "Server: Microsoft-IIS\/7\.5" CRLF;/' /tmp/nginx-${NGINX_VERSION}/src/http/ngx_http_header_filter_module.c \
&&  grep 'static char ngx_http_server' /tmp/nginx-${NGINX_VERSION}/src/http/ngx_http_header_filter_module.c \
&&  sed -i'' 's/\#define NGINX_VER          "nginx\/" NGINX_VERSION/#define NGINX_VER          "Microsoft-IIS\/7\.5"/' /tmp/nginx-${NGINX_VERSION}/src/core/nginx.h \
&&  grep 'NGINX_VER' /tmp/nginx-${NGINX_VERSION}/src/core/nginx.h

# Compile Ngnix
# #######################
# http://nginx.org/en/docs/configure.html
RUN cd /tmp/nginx-${NGINX_VERSION} \
&& ./configure --prefix=/usr/local/nginx --pid-path=/run/nginx.pid \
      --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log \
	  --http-client-body-temp-path=/var/lib/nginx/body_temp \
      --http-proxy-temp-path=/var/lib/nginx/proxy_temp \
      --http-fastcgi-temp-path=/var/lib/nginx/fastcgi_temp  \
      --http-scgi-temp-path=/var/lib/nginx/scgi_temp  \
      --http-uwsgi-temp-path=/var/lib/nginx/uwsgi_temp \
      --user=www-data \
      --group=www-data \
      --with-http_ssl_module \
      --with-http_stub_status_module \
      --with-http_realip_module \
      --with-http_v2_module \
      --with-http_gzip_static_module \
      --with-http_gunzip_module \
      --with-ipv6 \
      --with-pcre   \
      --without-http_autoindex_module \
      --without-http_ssi_module \
	&& make install

# --with-http_geoip_module
# --add-module=/tmp/ngx_pagespeed-$NPS_VERSION-beta

# Cleanup
# #######################
#RUN rm -Rf /tmp/ngx_pagespeed-1.8.31.3-beta
RUN rm -Rf /tmp/nginx-${NGINX_VERSION} \
    apt-get apt-utils purge \
      build-essential \
      libpcre3 libpcre3-dev libssl-dev libperl-dev \
      zlib1g-dev \
      wget zip \
    apt-get autoremove \
    apt-get clean

RUN  cp /usr/local/nginx/html/* /data/html/
RUN chown -R www-data:www-data /data/html
# TLS Certificat
# #######################
# ADD build/ssl /data/cert


# Configure nginx
# #######################
COPY build/nginx.conf /usr/local/nginx/conf/nginx.conf
COPY /build/sites-enabled /usr/local/nginx/sites-enabled



# forward request and error logs to docker log collector
# #######################
#RUN ln -sf /dev/stdout /var/log/nginx/access.log
#RUN ln -sf /dev/stderr /var/log/nginx/error.log



# Start Command
# #######################
# WORKDIR /etc/nginx/
#CMD ["/usr/sbin/nginx"]
#CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
CMD ["/usr/local/nginx/sbin/nginx"]




