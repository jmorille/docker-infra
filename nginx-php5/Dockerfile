#jmorille/nginx-php5
FROM jmorille/nginx

ENV php_conf="/etc/php5/cli/php.ini"
ENV fpm_conf="/etc/php5/fpm/php-fpm.conf"

# Install dependencies
# #######################
RUN apt-get update -qq && \
    apt-get install -yqq --force-yes  --fix-missing \
       php5-cli  \
       php5-fpm  \
       php5-mysql

COPY /build/sites-enabled /usr/local/nginx/sites-enabled
COPY /build/html /data/html
RUN chown -R www-data:www-data /data/html


# tweak php-fpm config
#RUN sed -i -e "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g" ${php_conf} && \
#sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 100M/g" ${php_conf} && \
#sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 100M/g" ${php_conf} && \
#sed -i -e "s/variables_order = \"GPCS\"/variables_order = \"EGPCS\"/g" ${php_conf} && \
#sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" ${fpm_conf} && \
#sed -i -e "s/;catch_workers_output\s*=\s*yes/catch_workers_output = yes/g" ${fpm_conf} && \
#sed -i -e "s/pm.max_children = 4/pm.max_children = 4/g" ${fpm_conf} && \
#sed -i -e "s/pm.start_servers = 2/pm.start_servers = 3/g" ${fpm_conf} && \
#sed -i -e "s/pm.min_spare_servers = 1/pm.min_spare_servers = 2/g" ${fpm_conf} && \
#sed -i -e "s/pm.max_spare_servers = 3/pm.max_spare_servers = 4/g" ${fpm_conf} && \
#sed -i -e "s/pm.max_requests = 500/pm.max_requests = 200/g" ${fpm_conf} && \
#sed -i -e "s/user = nobody/user = nginx/g" ${fpm_conf} && \
#sed -i -e "s/group = nobody/group = nginx/g" ${fpm_conf} && \
#sed -i -e "s/;listen.mode = 0660/listen.mode = 0666/g" ${fpm_conf} && \
#sed -i -e "s/;listen.owner = nobody/listen.owner = nginx/g" ${fpm_conf} && \
#sed -i -e "s/;listen.group = nobody/listen.group = nginx/g" ${fpm_conf} && \
#sed -i -e "s/listen = 127.0.0.1:9000/listen = \/var\/run\/php-fpm.sock/g" ${fpm_conf} && \
#sed -i -e "s/^;clear_env = no$/clear_env = no/" ${fpm_conf}
