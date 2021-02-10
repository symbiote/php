FROM php:7.1-fpm

RUN usermod -u 1000 www-data

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get install -my gnupg \
  && echo 'deb https://packages.tideways.com/apt-packages debian main' > /etc/apt/sources.list.d/tideways.list \
  && curl --silent -L -o- https://packages.tideways.com/key.gpg | apt-key add - \
  && apt-get update \
  && apt-get install -y --allow-unauthenticated \
      default-mysql-client \
      gettext-base \
      libtidy-dev \
      libpng-dev \
      libjpeg62-turbo-dev \
      libfreetype6-dev \
      libgmp-dev \
      libmcrypt-dev \
      libicu-dev \
      libwebp-dev \
      libxslt1-dev \
      libxslt1.1 \
      ldap-utils \
      ldapscripts \
      libldb-dev \
      libldap2-dev \
      msmtp \
      openssh-client \
      tideways-daemon \
      tideways-php \
      tideways-cli \
      unzip \
   && ln -s /usr/lib/x86_64-linux-gnu/libldap.so /usr/lib/libldap.so \
   && ln -s /usr/lib/x86_64-linux-gnu/liblber.so /usr/lib/liblber.so \
   && rm -rf /var/lib/apt/lists/* \
   && cp /usr/lib/tideways/tideways.ini /usr/local/etc/php/conf.d/

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ --with-webp-dir=/usr/include \
   && docker-php-ext-configure gmp \
   && docker-php-ext-install \
      sockets \
      gd \
      gmp \
      mysqli \
      tidy \
      mbstring \
      mcrypt \
      opcache \
      xsl \
      pdo_mysql \
      intl \
      soap \
      zip \
   && pecl install redis-4.0.2 \
   && pecl install timecop-beta \
   && pecl install xdebug-2.9.8\
   && docker-php-ext-enable \
      redis

ENV TZ=Australia/Melbourne

RUN echo '[Date]\ndate.timezone = "Australia/Melbourne"' >> /usr/local/etc/php/conf.d/timezone.ini \
    && echo "account default\nhost mailhog\nport 1025\ntls off\nfrom noreply@symbiote.io" > /etc/msmtprc \
    && echo "sendmail_path = /usr/bin/msmtp -t" > /usr/local/etc/php/conf.d/sendmail.ini \
    && ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone \
    && mkdir -p /var/log/php \
    && chown www-data /var/log/php

COPY php.ini /usr/local/etc/php/php.ini
COPY xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini
COPY memory.ini /usr/local/etc/php/conf.d/memory.ini

