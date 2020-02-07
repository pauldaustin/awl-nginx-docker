FROM openresty/openresty:centos

RUN /usr/local/openresty/luajit/bin/luarocks install lua-resty-lrucache
RUN /usr/local/openresty/luajit/bin/luarocks install lua-resty-http
RUN touch /usr/local/openresty/nginx/html/robots933456.txt

COPY config/default.conf /etc/nginx/conf.d/default.conf
COPY lua/*.lua /usr/local/openresty/site/lualib/

