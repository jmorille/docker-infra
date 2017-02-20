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


# Install dependencies
# #######################
#Set timezone
# RUN apk add --no-cache tzdata \
#    && cp /usr/share/zoneinfo/`echo $PHP_DATE_TIMEZONE` /etc/localtime


# Install dependencies for PHP extentions
RUN docker-php-ext-install mbstring mysqli pdo pdo_mysql json

# Display Config
# RUN cat /usr/local/etc/php-fpm.conf

# Configure and install PHP extentions
#RUN docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr \
#    && pecl bundle -d /usr/src/php/ext redis \
#    && rm /usr/src/php/ext/redis-*.tgz \
#    && docker-php-ext-install gd pdo pdo_mysql pdo_pgsql xmlrpc mcrypt opcache redis zip


# Set UID for www-data user to 33
# RUN deluser xfs \
#        && deluser www-data \
#        && addgroup -g 33 -S www-data \
#        && adduser -u 33 -D -S -G www-data -h /var/www -g www-data www-data

# Set UID for www-data user to 48 instead of 33
RUN groupmod -g 48 www-data

RUN echo "<?php phpinfo(); ?>" > /data/www/info.php && \
        chown -R www-data:www-data /data/www

# CMD ["/usr/local/sbin/php-fpm"]




