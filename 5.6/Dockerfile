FROM php:5.6-fpm

RUN usermod -u 1000 www-data


RUN apt-get update \
  && apt-get install -my gnupg apt-transport-https \
  && echo 'deb https://packages.tideways.com/apt-packages-main any-version main' | tee /etc/apt/sources.list.d/tideways.list \
  && curl --silent -L -o- https://packages.tideways.com/key.gpg | apt-key add - \
  && apt-get update && apt-get install -y \
      mysql-client \
      gettext-base \
      libtidy-dev \
      libpng-dev \
      libjpeg62-turbo-dev \
      libfreetype6-dev \
      libgmp-dev\
      libmcrypt-dev \
      libicu-dev \
      libwebp-dev \
      libxslt1-dev \
      libxslt1.1 \
      ldap-utils \
      ldapscripts \
      libldb-dev \
      libldap2-dev \
      openssh-client \
      ssmtp \
      tideways-daemon \
      tideways-php \
      tideways-cli \
      unzip   && rm -rf /var/lib/apt/lists/* \
  && ln -s /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/libldap.so \
  && ln -s /usr/lib/x86_64-linux-gnu/liblber.so /usr/lib/liblber.so \
  && cp /usr/lib/tideways/tideways.ini /usr/local/etc/php/conf.d/

RUN ln -s /usr/include/x86_64-linux-gnu/gmp.h /usr/include/gmp.h \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-webp-dir=/usr/include \
    && docker-php-ext-install \
			sockets \
      gd \
      gmp \
      mysqli \
      tidy \
      mbstring \
      mcrypt \
      opcache \
      pdo_mysql \
      xsl \
      intl \
      soap \
      zip \
    && pecl install redis-4.0.2 \
    && pecl install timecop-beta \ 
    && pecl install xdebug-2.5.5 \
    && docker-php-ext-enable \
      redis

ENV TZ=Australia/Melbourne

RUN echo '[Date]\ndate.timezone = "Australia/Melbourne"' >> /usr/local/etc/php/conf.d/timezone.ini \
    && echo "mailhub=mailhog:1025\nUseTLS=NO\nFromLineOverride=YES" > /etc/ssmtp/ssmtp.conf \
    && echo "sendmail_path = /usr/sbin/ssmtp -t" > /usr/local/etc/php/conf.d/sendmail.ini \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && mkdir -p /var/log/php \
    && chown www-data /var/log/php 

COPY php.ini /usr/local/etc/php/php.ini
COPY xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
COPY memory.ini /usr/local/etc/php/conf.d/memory.ini