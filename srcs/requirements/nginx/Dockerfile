FROM debian:bookworm-slim

RUN apt-get -y update \
    && apt-get install -y --no-install-recommends \
    nginx \
    openssl \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/certs \
    && openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/certs/nginx.key -out /etc/nginx/certs/nginx.cert -subj "/CN=localhost"

COPY nginx/conf /etc/nginx/sites-enabled/default

COPY index.html /var/www/html/index.html
COPY index.php /var/www/html/index.php

EXPOSE 443

ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]

HEALTHCHECK CMD curl -kf https://localhost || exit 1

