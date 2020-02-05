FROM openresty/openresty:centos

RUN /usr/local/openresty/luajit/bin/luarocks install lua-resty-lrucache
RUN /usr/local/openresty/luajit/bin/luarocks install lua-resty-http

COPY config/default.conf /etc/nginx/conf.d/default.conf
COPY lua/*.lua /usr/local/openresty/nginx/

