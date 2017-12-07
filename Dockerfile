FROM php:latest

ENV COMPOSER_ALLOW_SUPERUSER 1

RUN apt-get update && apt-get install -y zlib1g-dev \
	unzip \
	rsync

RUN docker-php-ext-install zip

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php --install-dir=/usr/bin --filename=composer
RUN rm composer-setup.php

ENV PATH=/root/.composer/vendor/bin:$PATH

RUN composer global require deployer/deployer:6.0.3

RUN mkdir -p /var/www

WORKDIR /var/www

CMD dep
