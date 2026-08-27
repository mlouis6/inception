# User Documentation

## What is it
This is a web stack using 3 containers:
- nginx: used for the server
- mariadb: used to store and manage datas
- wordpress: used to display and manage website

Nginx container is the entrypoint, and every container is connected via a Docker Network.

## How to use

### Set up environment

#### `.env` file

Before doing anything, the user will need to create an `.env` file inside the `srcs/` directory.
Here is the template for the file, just add the desired values after the equal sign:
```
WORDPRESS_PORT=
WORDPRESS_DB_HOST=
WORDPRESS_DB_NAME=
WORDPRESS_DB_USER=
WORDPRESS_DB_PASSWORD=

MYSQL_DATABASE=
MYSQL_USER=
MYSQL_PASSWORD=

USER_ADMIN=
PASSWORD_ADMIN=
EMAIL_ADMIN=

USER_ONE=
PASSWORD_ONE=
EMAIL_ONE=
```

Those values are sensitive, do not share them or publish them anywhere.

#### Path to persistent data

The path to the volume also need to be updating, so change the values defined after ``device`` for each volume in the `docker-compose.yml` file:

```yaml
volumes:
  wp-data:
    [...]
    driver_opts:
      device: <path to wordpress data>
  db-data:
    [...]
    driver_opts:
      device: <path to mariadb data>
```

This change also need to be made in the `Makefile`:
```make
all:
	mkdir -p <path to wordpress data>
	mkdir -p <path to mariadb data>
	$(COMPOSE) up --build

up:
	mkdir -p <path to wordpress data>
	mkdir -p <path to mariadb data>
	$(COMPOSE) up -d --build

[...]

fclean:
	$(COMPOSE) down -v --rmi local
	sudo rm -rf <path to wordpress data>
	sudo rm -rf <path to mariadb data>

[...]

re:
	$(COMPOSE) down -v --rmi local
	sudo rm -rf <path to wordpress data>
	sudo rm -rf <path to mariadb data>
	mkdir -p <path to wordpress data>
	mkdir -p <path to mariadb data>
	$(COMPOSE) up -d
```

These directories should **not be deleted manually** while the project is running.

### Start and stop the project

Then, a simple `make` command can be use to build all images and run the containers. 

Finally, the user will just have to open the browser of its choice and go to https://mlouis.42.fr.

If the user prefer to launch in detach mode, the use of `make up` is recommended.

To start and stop containers, use the commands `make start` and `make stop`.

The command `make down` can be use to stop and remove the containers. It will also delete the network.

To also remove the images and the volumes, the user can do `make fclean`. Be carefule, this will delete persistent data.

To get rid of cache, use `make prune`

### Check on the Docker environment

In case the user want to check anything `make check` can help and display any informations for containers, with their health status, to network.

### Log into the website

To log on the website, access https://mlouis.42.fr/wp-login. The user can use the admin username and password from their `.env` file (`USER_ADMIN` and `PASSWORD_ADMIN`) if they want to manage the website or the other credentials (`USER_ONE` and `PASSWORD_ONE`) to be a lambda user and be able to comment.

### Manage the website

Once logged as the user defined as admin (set with `USER_ADMIN`), access the admin panel at https://mlouis.42.fr/wp-admin.

The menu at the left allows to manage users and pages as needed.

<!-- TODO: add more info about admin panel -->
