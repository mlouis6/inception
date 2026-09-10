#!/bin/bash
set -e

chown -R www-data:www-data /var/www/html/

if [ ! -e "/var/www/html/wp-load.php" ]; then
	sudo -u www-data wp --path="/var/www/html" core download
fi

if [ ! -e "/var/www/html/wp-config.php" ]; then

	sudo -u www-data wp --path="/var/www/html" config create \
		--dbname="$WORDPRESS_DB_NAME" \
		--dbuser="$WORDPRESS_DB_USER" \
		--dbpass="$WORDPRESS_DB_PASSWORD" \
		--dbhost="$WORDPRESS_DB_HOST"

	if ! sudo -u www-data wp --path="/var/www/html" core is-installed; then
		sudo -u www-data wp --path="/var/www/html" core install \
			--url="https://mlouis.42.fr" \
			--title="WIP" \
			--admin_user="$USER_ADMIN" \
			--admin_password="$PASSWORD_ADMIN" \
			--admin_email="$EMAIL_ADMIN"
	fi

	sudo -u www-data wp --path="/var/www/html/" user create \
		"$USER_ONE" \
		"$EMAIL_ONE" \
		--user_pass="$PASSWORD_ONE"
fi

exec php-fpm8.2 -F

