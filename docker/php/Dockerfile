FROM php:8.3-fpm

RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libonig-dev \
    libxml2-dev \
    zip unzip curl git \
    libzip-dev \
    && docker-php-ext-configure gd --with-jpeg \
    && docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd zip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Установка Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

# Копируем только composer файлы сначала, чтобы избежать повторной установки при изменении кода
COPY composer.json composer.lock ./

RUN composer install --no-dev --no-scripts --prefer-dist --no-progress --no-interaction

# Теперь копируем весь проект
COPY . .
# Повторный запуск composer install с учетом скриптов (если они есть)
RUN composer install --optimize-autoloader7               