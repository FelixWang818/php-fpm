FROM php:7.4.16-fpm-alpine

ENV LANG=C.UTF-8

COPY resource /home/resource

WORKDIR /home/resource

RUN sed -i "s/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g" /etc/apk/repositories

RUN chmod +x install.sh \
    && sh install.sh \
    && rm -rf /home/resource \
    && apk --no-cache add tzdata \
    && cp "/usr/share/zoneinfo/Asia/Shanghai" /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone \
    # Fix: https://github.com/docker-library/php/issues/240
    && apk add gnu-libiconv libstdc++ --no-cache --repository http://mirrors.aliyun.com/alpine/edge/community/ --allow-untrusted \
    # Install composer and change it's cache home
    && curl -o /usr/bin/composer https://mirrors.aliyun.com/composer/composer.phar \
    && chmod +x /usr/bin/composer \
    # php image's www-data user uid & gid are 82, change them to 1000 (primary user)
    && apk --no-cache add shadow && usermod -u 1000 www-data && groupmod -g 1000 www-data

WORKDIR /etc/nginx/html