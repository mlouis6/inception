FROM debian:bookworm-slim

RUN apt-get -y update && apt-get install -y nginx

RUN rm -f /etc/nginx/sites-enabled/default

COPY requirements/nginx/conf /etc/nginx/sites-enabled/default

COPY requirements/index.html /var/www/html/index.html

EXPOSE 443

CMD ["nginx", "-g", "daemon off;"]

