#!/bin/bash
set -ex


# TODO: get fmp version
PHP_VERSION="$(ls /etc/php/ | tail -1)"
PHP_CMD="php-fpm${PHP_VERSION} -F"

# wp core download --allow-root

if [ ! -e "/var/www/html/wp-config.php" ]; then

	wp config create \
		--dbname="$WORDPRESS_DB_NAME" \
		--dbuser="$WORDPRESS_DB_USER" \
		--dbpass="$WORDPRESS_DB_PASSWORD" \
		--dbhost="$WORDPRESS_DB_HOST" \
		--allow-root

	if ! wp core is-installed; then
		wp core install \
			--url="https://mlouis.42.fr" \
			--title="WIP" \
			--admin_user="$USER_ADMIN" \
			--admin_password="$PASSWORD_ADMIN" \
			--admin_email="$EMAIL_ADMIN" \
			--allow-root
	fi
fi

${PHP_CMD}

