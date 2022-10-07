FROM php:7.3-apache

# Note: php:7-apache is a debian based image.
# Note: mycrypt extension is not provided with the PHP source since 7.2.
#       Instead it is available through PECL. 
#       To install a PECL extension in docker, 
#          use `pecl install <packagename-version>` to download and compile it, 
#          then use `docker-php-ext-enable` to enable it:
#RUN apt install apache2 utils -y
RUN apt-get update && apt-get install -y \
      libmcrypt-dev \
      libfreetype6-dev \
      libjpeg-dev \
      libpng-dev \
      libxml2-dev \
      libtidy-dev \
      libxslt-dev \
      libc-client-dev libkrb5-dev \
      libicu-dev \
      libldb-dev libldap2-dev \
      libgmp-dev \
      libbz2-dev \
      libzip-dev \
    && a2enmod rewrite expires \
#    && pecl install mcrypt-1.0.1 \
    && docker-php-ext-install gd mysqli opcache iconv bcmath gettext soap sockets tidy xmlrpc xsl pdo_mysql exif intl ldap pcntl gmp bz2 calendar zip \    
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl && docker-php-ext-install imap intl \
    && docker-php-ext-configure gd \
       --with-freetype-dir=/usr/include/ \
       --with-jpeg-dir=/usr/include/ \
       --with-png-dir=/usr/include/ \
#    && docker-php-ext-enable mcrypt mysqli


RUN curl -sS https://getcomposer.org/installer | \
  php -- --install-dir=/usr/local/bin --filename=composer
