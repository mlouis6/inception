#!/bin/bash
set -ex

mkdir -p /run/mysqld
chown mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

mariadb-install-db \
	--user=mysql --datadir=/var/lib/mysql

mariadbd --user=mysql --skip-networking & pid="$!"

until mariadb -u root -e "SELECT 1;" >/dev/null 2>&1; do
	sleep 0.2
done

mariadb -u root -vvv <<EOF
CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

mariadb-admin -u root shutdown
wait "$pid"

exec mariadbd --user=mysql
