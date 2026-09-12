FROM debian:bookworm-slim

ENV LANG=C.UTF-8

RUN apt-get -y update \
    && apt-get install -y --no-install-recommends \
    nginx \
    curl \
    && rm -rf /var/lib/apt/lists/*

COPY nginx/conf /etc/nginx/sites-enabled/default

EXPOSE 443

ENTRYPOINT ["nginx"]
CMD ["-g", "daemon off;"]

HEALTHCHECK --start-period=10s --start-interval=1s CMD curl -kf https://localhost || exit 1
