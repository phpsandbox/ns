FROM alpine:3.9

Maintainer Olatunbosun Egberinde <bosunski@gmail.com>

ADD https://dl.bintray.com/php-alpine/key/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub

ARG PHP_VERSION=7.4
ARG ALPINE_VERSION=3.9

# CONFIGURE ALPINE REPOSITORIES AND PHP BUILD DIR.
RUN echo "http://dl-cdn.alpinelinux.org/alpine/v${ALPINE_VERSION}/main" > /etc/apk/repositories && \
    echo "http://dl-cdn.alpinelinux.org/alpine/v${ALPINE_VERSION}/community" >> /etc/apk/repositories && \
#    echo "@php https://php.codecasts.rocks/v${ALPINE_VERSION}/php-${PHP_VERSION}" >> /etc/apk/repositories
    echo "@php https://dl.bintray.com/php-alpine/v${ALPINE_VERSION}/php-${PHP_VERSION}" >> /etc/apk/repositories

# INSTALL PHP AND SOME EXTENSIONS. SEE: https://github.com/codecasts/php-alpine
RUN apk add --no-cache --update curl \
	git \
	php-fpm@php \
    php@php \
    php-pdo@php \
    php-curl@php \
    php-iconv@php \
    php-bcmath@php \
    php-pcntl@php \
    php-posix@php \
    php-mysqlnd@php \
    php-pdo_mysql@php \
    php-mbstring@php \
    php-phar@php \
    php-session@php \
    php-dom@php \
    php-ctype@php \
    php-zlib@php \
    php-json@php \
    php-xml@php && \
    ln -s /usr/bin/php7 /usr/bin/php

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

RUN mkdir -p /var/www

WORKDIR /var/www

COPY . /var/www

VOLUME /var/www

CMD ["/bin/sh"]

ENTRYPOINT ["/bin/sh", "-c"]
