FROM debian:bookworm-slim

RUN apt-get -y update \
    && apt-get install -y --no-install-recommends \
    php-fpm \
    ca-certificates \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

RUN wget https://wordpress.org/latest.zip \
    && unzip latest.zip \
    && mv wordpress/* . \
    && rm -rf wordpress latest.zip

RUN chown -R www-data:www-data /var/www/html

RUN sed -i 's|^listen = .*|listen = 9000|' \
    /etc/php/8.2/fpm/pool.d/www.conf

# RUN systemctl enable --now php8.4-fpm

EXPOSE 9000

CMD ["php-fpm8.2", "-F"]


# CMD ["nginx", "-g", "daemon off;"]
