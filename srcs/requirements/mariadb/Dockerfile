FROM debian:bookworm-slim

RUN apt-get -y update \
    && apt-get install -y --no-install-recommends \
    mariadb-server \
    mariadb-client \
    galera-4 \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /run/mysqld \
    && chown -R mysql:mysql /var/lib/mysql \
    && mariadb-install-db --user=mysql --datadir=/var/lib/mysql

USER mysql

EXPOSE 3306

# ENTRYPOINT ["mariadb"]
# CMD ["-u", "minda", "-p", $ADPASS]

# ENTRYPOINT ["systemctl", "start", "mariadb"]

ENTRYPOINT ["mariadbd"]

# HEALTHCHECK CMD systemctl status mariadb || exit 1

