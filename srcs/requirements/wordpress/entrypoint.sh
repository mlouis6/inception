#!/bin/bash
set -ex

PHP_VERSION="$(ls /etc/php/ | tail -1)"
PHP_CMD="php-fpm${PHP_VERSION} -F"

# wp core download --allow-root
chown -R www-data:www-data /var/www/html/

if [ ! -e "/var/www/html/wp-config.php" ]; then

	sudo -u www-data wp config create \
		--dbname="$WORDPRESS_DB_NAME" \
		--dbuser="$WORDPRESS_DB_USER" \
		--dbpass="$WORDPRESS_DB_PASSWORD" \
		--dbhost="$WORDPRESS_DB_HOST"

	# if ! sudo -u www-data wp core is-installed; then
	if ! wp core is-installed; then
		wp core install \
			--url="https://mlouis.42.fr" \
			--title="WIP" \
			--admin_user="$USER_ADMIN" \
			--admin_password="$PASSWORD_ADMIN" \
			--admin_email="$EMAIL_ADMIN" \
			--allow-root
	fi

	wp user create \
		"$USER_BILLY" \
		"$EMAIL_BILLY" \
		--user_pass="$PASSWORD_BILLY" \
		--allow-root

fi

exec ${PHP_CMD}

