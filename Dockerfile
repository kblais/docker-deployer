FROM php:latest

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_VENDOR_DIR "/root/.composer/vendor"

RUN apt-get update && apt-get install -y zlib1g-dev \
	unzip \
	rsync \
	ssh \
	git

RUN docker-php-ext-install zip

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php --install-dir=/usr/bin --filename=composer
RUN rm composer-setup.php

ENV PATH=/root/.composer/vendor/bin:$PATH

RUN composer global require deployer/deployer:v6.3.0

RUN mkdir -p /var/www

WORKDIR /var/www

CMD dep
