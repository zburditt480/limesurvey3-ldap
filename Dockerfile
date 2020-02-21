FROM php:7.3.14-apache
RUN docker-php-source extract && \
docker-php-ext-install pdo_mysql && \
docker-php-ext-enable pdo_mysql && \
apt-get update && apt-get install libldap2-dev -y && \
rm -rf /var/lib/apt/lists/* && \
docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && \
docker-php-ext-install ldap && docker-php-source delete 
COPY ./limesurvey /var/www/html/limesurvey
RUN chmod -R 777 /var/www/html/limesurvey/tmp/ /var/www/html/limesurvey/upload/ /var/www/html/limesurvey/application/config/
