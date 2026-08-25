FROM debian:bookworm-slim

ENV LANG=C.UTF-8

RUN apt-get -y update \
    && apt-get install -y --no-install-recommends \
    nginx \
    curl \
    && rm -rf /var/lib/apt/lists/*

# need openssl
# RUN mkdir -p /etc/nginx/certs \
#     && openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/certs/nginx.key -out /etc/nginx/certs/nginx.cert -subj "/CN=mlouis.42.fr"

COPY nginx/conf /etc/nginx/sites-enabled/default
COPY nginx/certs/nginx.crt /etc/nginx/certs/nginx.crt
COPY nginx/certs/nginx.key /etc/nginx/certs/nginx.key

EXPOSE 443

ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]

HEALTHCHECK --start-period=10s --start-interval=1s CMD curl -kf https://localhost || exit 1

