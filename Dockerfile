FROM php:7.2-cli

MAINTAINER jgguo <jgguo2596@gmail.com>

#############################################################################################
# 安装基本要求
RUN apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -q -y \
    libmcrypt-dev \
    procps \
    git \
    python-pip \
    python-setuptools \
    && pip install wheel \
    && pip install supervisor supervisor-stdout \
    && ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#安装 各种扩展
RUN yes '' | pecl install mcrypt-1.0.1 \
    && yes '' | pecl install swoole-4.4.8 \
    && yes '' | pecl install mongodb-1.6.0 \
    && yes '' | pecl install redis-5.0.2 \
    && yes '' | pecl install inotify-2.0.0 \
    && docker-php-ext-enable mcrypt swoole mongodb redis inotify \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install pcntl

# Supervisor config
ADD ./conf/supervisord.conf /etc/supervisord.conf

# Add Scripts
ADD ./start.sh /start.sh

EXPOSE 80 443

CMD ["/start.sh"]
