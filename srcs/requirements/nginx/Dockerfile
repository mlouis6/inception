FROM debian:bookworm-slim

RUN apt-get -y update \
    && apt-get install -y --no-install-recommends \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/certs \
    && openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/certs/admantium.key -out /etc/nginx/certs/admantium.cert -subj "/CN=localhost"

COPY nginx/conf /etc/nginx/sites-enabled/default

COPY index.html /var/www/html/index.html
COPY index.php /var/www/html/index.php

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]

