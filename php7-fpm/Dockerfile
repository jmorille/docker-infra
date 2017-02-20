#jmorille/php7-fpm
FROM php:7-fpm


# Set environment variables to use them in PHP config files
#ENV FPM_PM static
#ENV FPM_PM_MAX_CHILDREN 4
#ENV PHP_DATE_TIMEZONE Europe/Paris
#ENV PHP_MEMORY_LIMIT 256M
#ENV PHP_POST_MAX_SIZE 20M
#ENV PHP_UPLOAD_MAX_SIZE 20M
#ENV PHP_SMTP localhost
#ENV PHP_SMTP_PORT 25

# Expose
# #######################
EXPOSE 9000
VOLUME ["/data/www"  ]

# WORKDIR /var/www/html

# Install dependencies
# #######################
#Set timezone
# RUN apk add --no-cache tzdata \
#    && cp /usr/share/zoneinfo/`echo $PHP_DATE_TIMEZONE` /etc/localtime
# Display Config
# RUN cat /usr/local/etc/php-fpm.conf

# Install dependencies for PHP extentions
RUN apt-get update \
 && apt-get install -y  apt-utils zlib1g-dev libicu-dev g++ \
 && docker-php-ext-configure intl \
 && docker-php-ext-install mbstring mysqli pdo pdo_mysql json intl


# Set UID for www-data user to 48 instead of 33
RUN groupmod -g 48 www-data \
 && chown -R www-data:www-data /data/www

#RUN echo "<?php phpinfo(); ?>" > /data/www/info.php && \
#        chown -R www-data:www-data /data/www





