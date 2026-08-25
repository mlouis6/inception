FROM debian:bookworm-slim

ENV LANG=C.UTF-8

RUN apt-get -y update \
    && apt-get install -y --no-install-recommends \
    php-fpm \
    php-mysql \
    ca-certificates \
    wget \
    unzip \
    netcat-openbsd \
    # sudo \
    && rm -rf /var/lib/apt/lists/*


RUN wget https://wordpress.org/latest.zip \
    && unzip latest.zip \
    && mv wordpress/* . \
    && rm -rf wordpress latest.zip \
    && wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp \
    && sed -i 's/^listen = .*/listen = 9000/' \
    /etc/php/8.2/fpm/pool.d/www.conf

COPY --chown=www-data:www-data web/ /var/www/html/

# RUN chown -R www-data:www-data /var/www/html/

EXPOSE 9000

COPY --chmod=+x entrypoint.sh /entrypoint.sh

WORKDIR /var/www/html

ENTRYPOINT ["/entrypoint.sh"]

HEALTHCHECK CMD nc -z localhost 9000 || exit 1
