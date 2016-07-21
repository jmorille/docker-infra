#jmorille/nginx-php5
FROM jmorille/nginx

# Install dependencies
# #######################
RUN apt-get update -qq && \
    apt-get install -yqq --force-yes  --fix-missing \
       php5-fpm  \
       php5-mysql

COPY /build/sites-enabled /usr/local/nginx/sites-enabled
COPY /build/html /data/html
