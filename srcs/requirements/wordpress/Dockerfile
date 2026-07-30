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

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar

RUN    mv wp-cli.phar /usr/local/bin/wp

RUN chown -R www-data:www-data /var/www/html

RUN sed -i 's/^listen = .*/listen = 9000/' \
    /etc/php/8.2/fpm/pool.d/www.conf

# RUN sed -i 's|^listen = .*|listen = /var/run/php/php8.2-fpm.sock|' \
#     /etc/php/8.2/fpm/pool.d/www.conf

# RUN echo "listen = wordpress:9000" > /var/run/php/php8.2-fpm.sock

COPY web/ /var/www/html/

EXPOSE 9000

# ENTRYPOINT ["php-fpm8.2"]
# CMD ["-F"]

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

HEALTHCHECK CMD nc -z localhost 9000 || exit 1
