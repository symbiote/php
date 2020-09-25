FROM php:8.0-rc-fpm

RUN usermod -u 1000 www-data

# See https://github.com/wodby/php/blob/master/7/Dockerfile
# https://github.com/wodby/drupal-php/issues/49
# for tideways installation

RUN apt-get update \
	&& apt-get install -my gnupg \
	&& apt-get install -y --allow-unauthenticated \
      default-mysql-client \
      libzip-dev \
      libtidy-dev \
      libpng-dev \
      libjpeg62-turbo-dev \
      libfreetype6-dev \
      libmcrypt-dev \
      libonig-dev \
      libicu-dev \
      libxslt1-dev \
      libxslt1.1 \
      msmtp \
  && rm -rf /var/lib/apt/lists/* 

RUN docker-php-ext-configure gd  \
    && docker-php-ext-install \
			sockets \
      gd \
      mysqli \
      tidy \
      mbstring \
      opcache \
      xsl \
      pdo_mysql \
      intl \
      zip \
      soap 

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