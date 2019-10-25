FROM php:7.2-cli

#############################################################################################
# Install Basic Requirements
RUN apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -q -y \
    libmcrypt-dev \
    procps \
    git

#安装 各种扩展
RUN yes '' | pecl install mcrypt-1.0.1 \
    && yes '' | pecl install swoole-4.4.8 \
    && yes '' | pecl install mongodb-1.6.0 \
    && yes '' | pecl install redis-5.0.2 \
    && yes '' | pecl install inotify-2.0.0 \
    && docker-php-ext-enable mcrypt swoole mongodb redis inotify \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install pcntl \



