# php-fpm 扩展安装说明 
本说明扩展针对PHP7版本，若使用PHP5版本请更改部分扩展的版本
pecl查询网址：http://pecl.php.net/

# 常用扩展的安装
docker-php-ext-install -j$(nproc) bcmath calendar exif gettext sockets dba mysqli pcntl pdo_mysql shmop sysvmsg sysvsem sysvshm

# bz2 扩展的安装, 读写 bzip2（.bz2）压缩文件
apt-get install -y --no-install-recommends libbz2-dev && \
rm -r /var/lib/apt/lists/* && \
docker-php-ext-install -j$(nproc) bz2

# enchant 扩展的安装, 拼写检查库
apt-get install -y --no-install-recommends libenchant-dev && \
rm -r /var/lib/apt/lists/* && \
docker-php-ext-install -j$(nproc) enchant

# gd 扩展的安装. 图像处理
apt-get install -y --no-install-recommends libfreetype6-dev libjpeg62-turbo-dev libpng-dev && \
rm -r /var/lib/apt/lists/* && \
docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && \
docker-php-ext-install -j$(nproc) gd

# gmp 扩展的安装, GMP
apt-get install -y --no-install-recommends libgmp-dev && \
rm -r /var/lib/apt/lists/* && \
docker-php-ext-install -j$(nproc) gmp

# soap wddx xmlrpc tidy xsl 扩展的安装
apt-get install -y --no-install-recommends libxml2-dev libtidy-dev libxslt1-dev && \
rm -r /var/lib/apt/lists/* && \
docker-php-ext-install -j$(nproc) soap wddx xmlrpc tidy xsl

# zip 扩展的安装
apt-get install -y --no-install-recommends libzip-dev && \
rm -r /var/lib/apt/lists/* && \
docker-php-ext-install -j$(nproc) zip

# snmp 扩展的安装
apt-get install -y --no-install-recommends libsnmp-dev && \
rm -r /var/lib/apt/lists/* && \
docker-php-ext-install -j$(nproc) snmp

# pgsql, pdo_pgsql 扩展的安装
apt-get install -y --no-install-recommends libpq-dev && \
rm -r /var/lib/apt/lists/* && \
docker-php-ext-install -j$(nproc) pgsql pdo_pgsql

# pspell 扩展的安装
apt-get install -y --no-install-recommends libpspell-dev && \
rm -r /var/lib/apt/lists/* && \
docker-php-ext-install -j$(nproc) pspell

# recode 扩展的安装
apt-get install -y --no-install-recommends librecode-dev && \
rm -r /var/lib/apt/lists/* && \
docker-php-ext-install -j$(nproc) recode

# pdo_firebird 扩展的安装
apt-get install -y --no-install-recommends firebird-dev && \
rm -r /var/lib/apt/lists/* && \
docker-php-ext-install -j$(nproc) pdo_firebird

# pdo_dblib 扩展的安装
apt-get install -y --no-install-recommends freetds-dev && \
rm -r /var/lib/apt/lists/* && \
docker-php-ext-configure pdo_dblib --with-libdir=lib/x86_64-linux-gnu && \
docker-php-ext-install -j$(nproc) pdo_dblib

# ldap 扩展的安装
apt-get install -y --no-install-recommends libldap2-dev && \
rm -r /var/lib/apt/lists/* && \
docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu && \
docker-php-ext-install -j$(nproc) ldap

# imap 扩展的安装
apt-get install -y --no-install-recommends libc-client-dev libkrb5-dev && \
rm -r /var/lib/apt/lists/* && \
docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
docker-php-ext-install -j$(nproc) imap

# interbase 扩展的安装
apt-get install -y --no-install-recommends firebird-dev && \
rm -r /var/lib/apt/lists/* && \
docker-php-ext-install -j$(nproc) interbase

# intl 扩展的安装
apt-get install -y --no-install-recommends libicu-dev && \
rm -r /var/lib/apt/lists/* && \
docker-php-ext-install -j$(nproc) intl

# mcrypt 扩展的安装
apt-get install -y --no-install-recommends libmcrypt-dev && \
rm -r /var/lib/apt/lists/* && \
pecl install mcrypt-1.0.3 && \
docker-php-ext-enable mcrypt

# imagick 扩展的安装
$ export CFLAGS="$PHP_CFLAGS" CPPFLAGS="$PHP_CPPFLAGS" LDFLAGS="$PHP_LDFLAGS" && \
apt-get install -y --no-install-recommends libmagickwand-dev && \
rm -rf /var/lib/apt/lists/* && \
pecl install imagick-3.4.4 && \
docker-php-ext-enable imagick

# memcached 扩展的安装
apt-get install -y --no-install-recommends zlib1g-dev libmemcached-dev && \
rm -r /var/lib/apt/lists/* && \
pecl install memcached-3.1.5 && \
docker-php-ext-enable memcached

# redis 扩展的安装
pecl install redis-5.2.1 && docker-php-ext-enable redis

# rrd 扩展的安装
apt-get install -y --no-install-recommends librrd-dev && \
pecl install rrd-2.0.1 && docker-php-ext-enable rrd && \

# opcache 扩展的安装
docker-php-ext-configure opcache --enable-opcache && docker-php-ext-install opcache

# ⬇ Swoole 扩展的安装 
pecl install swoole-4.4.16 && docker-php-ext-enable swoole

# odbc pdo_odbc扩展的安装
RUN set -ex; \
docker-php-source extract; \
{ \
	 echo '# https://github.com/docker-library/php/issues/103#issuecomment-271413933'; \
	 echo 'AC_DEFUN([PHP_ALWAYS_SHARED],[])dnl'; \
	 echo; \
	 cat /usr/src/php/ext/odbc/config.m4; \
} > temp.m4; \
mv temp.m4 /usr/src/php/ext/odbc/config.m4; \
apt-get update; \
apt-get install -y --no-install-recommends unixodbc-dev; \
rm -rf /var/lib/apt/lists/*; \
docker-php-ext-configure odbc --with-unixODBC=shared,/usr; \
docker-php-ext-configure pdo_odbc --with-pdo-odbc=unixODBC,/usr; \
docker-php-ext-install odbc pdo_odbc; \
docker-php-source delete && \

# sqlsrv pdo_sqlsrv 扩展 -20200323
pecl install sqlsrv-5.8.0 && docker-php-ext-enable sqlsrv && \
pecl install pdo_sqlsrv-5.8.0 && docker-php-ext-enable pdo_sqlsrv && \


# proxy 设置
export http_proxy="http://172.16.1.88:10809"; \
export https_proxy="http://172.16.1.88:10809"; \
export socks_proxy="http://172.16.1.88:10809"; \
export no_proxy="localhost,127.0.0.1";\
export HTTP_PROXY="http://172.16.1.88:10809"; \
export HTTPS_PROXY="http://172.16.1.88:10809"; \
export SOCKS_PROXY="http://172.16.1.88:10809"; \
export NO_PROXY="localhost,127.0.0.1"; \

