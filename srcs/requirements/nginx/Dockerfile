FROM debian:bookworm-slim

RUN apt-get -y update && apt-get install -y nginx

COPY srcs/requirements/index.html /var/www/html/index.nginx-debian.html

EXPOSE 81

CMD ["nginx", "-g", "daemon off;"]

