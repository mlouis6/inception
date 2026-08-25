#!/bin/bash
set -e

chown -R www-data:www-data /var/www/html/

if [ ! -e "/var/www/html/wp-config.php" ]; then

	runuser -u www-data wp config create \
		--dbname="$WORDPRESS_DB_NAME" \
		--dbuser="$WORDPRESS_DB_USER" \
		--dbpass="$WORDPRESS_DB_PASSWORD" \
		--dbhost="$WORDPRESS_DB_HOST"

	if ! runuser -u www-data wp core is-installed; then
		runuser -u www-data wp core install \
			--url="https://mlouis.42.fr" \
			--title="WIP" \
			--admin_user="$USER_ADMIN" \
			--admin_password="$PASSWORD_ADMIN" \
			--admin_email="$EMAIL_ADMIN"
	fi

	runuser -u www-data wp user create \
		"$USER_ONE" \
		"$EMAIL_ONE" \
		--user_pass="$PASSWORD_ONE"

fi

exec php-fpm8.2 -F

