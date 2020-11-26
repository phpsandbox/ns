FROM alpine:3.9

Maintainer Olatunbosun Egberinde <bosunski@gmail.com>

ADD https://dl.bintray.com/php-alpine/key/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub

ARG PHP_VERSION=8.0
ARG ALPINE_VERSION=3.11

# CONFIGURE ALPINE REPOSITORIES AND PHP BUILD DIR.
RUN echo "http://dl-cdn.alpinelinux.org/alpine/v${ALPINE_VERSION}/main" > /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/v${ALPINE_VERSION}/community" >> /etc/apk/repositories && \
#    echo "@php https://php.codecasts.rocks/v${ALPINE_VERSION}/php-${PHP_VERSION}" >> /etc/apk/repositories
    echo "@php https://dl.bintray.com/php-alpine/v${ALPINE_VERSION}/php-${PHP_VERSION}" >> /etc/apk/repositories

# INSTALL PHP AND SOME EXTENSIONS. SEE: https://github.com/codecasts/php-alpine
RUN apk add --no-cache --update curl \
	git \
	php8-fpm@php \
    php8@php \
    php8-pdo@php \
    php8-sqlite3@php \
    php8-pdo_sqlite@php \
    php8-curl@php \
    php8-iconv@php \
    php8-bcmath@php \
    php8-sodium@php \
    php8-pcntl@php \
    php8-curl@php \
    php8-posix@php \
    php8-mysqlnd@php \
    php8-pdo_mysql@php \
    php8-mbstring@php \
    php8-phar@php \
    php8-session@php \
    php8-dom@php \
    php8-ctype@php \
    php8-zlib@php \
#    php-json@php \
    php8-xml@php && \
    ln -s /usr/bin/php8 /usr/bin/php

#RUN apk --update add wget \
#		     curl \
#		     git \
#		     php7 \
#		     php7-curl \
#		     php7-openssl \
#		     php7-iconv \
#		     php7-json \
#		     php7-mbstring \
#		     php7-phar \
#		     php7-tokenizer \
#		     php7-dom --repository http://nl.alpinelinux.org/alpine/edge/testing/ && rm /var/cache/apk/*

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer

RUN composer

RUN mkdir -p /var/www

WORKDIR /var/www

COPY . /var/www

VOLUME /var/www

CMD ["/bin/sh"]

ENTRYPOINT ["/bin/sh", "-c"]
