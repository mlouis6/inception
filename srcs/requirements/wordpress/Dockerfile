FROM debian:bookworm-slim

RUN apt-get -y update \
    && apt-get install -y --no-install-recommends \
    php-fpm \
    php-mysql \
    ca-certificates \
    wget \
    unzip \
    netcat-openbsd \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html

RUN wget https://wordpress.org/latest.zip \
    && unzip latest.zip \
    && mv wordpress/* . \
    && rm -rf wordpress latest.zip

RUN chown -R www-data:www-data /var/www/html

RUN sed -i 's|^listen = .*|listen = 9000|' \
    /etc/php/8.2/fpm/pool.d/www.conf

COPY web/ /var/www/html/

EXPOSE 9000

ENTRYPOINT ["php-fpm8.2"]
CMD ["-F"]

HEALTHCHECK CMD nc -z localhost 9000 || exit 1
