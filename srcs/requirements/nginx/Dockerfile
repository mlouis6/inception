FROM debian:bookworm-slim

ENV LANG=C.UTF-8

RUN apt-get -y update \
    && apt-get install -y --no-install-recommends \
    nginx \
    openssl \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/certs \
    && openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/certs/nginx.key -out /etc/nginx/certs/nginx.cert -subj "/CN=localhost"

COPY nginx/conf /etc/nginx/sites-enabled/default

EXPOSE 443

ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]

HEALTHCHECK CMD curl -kf https://localhost || exit 1

