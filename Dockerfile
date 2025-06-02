FROM php:8.1-apache
RUN apt-get update && apt-get install -y \
  git unzip libicu-dev libpq-dev libzip-dev zip \
  && docker-php-ext-install intl pdo pdo_mysql zip
COPY . /var/www/html
WORKDIR /var/www/html
RUN chown -R www-data:www-data /var/www/html
