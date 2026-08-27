# Developer Documentation

## Overview

This project is a Docker **LEMP stack**, so based on ***L*inux** (here Debian Bookworm) with the following services:
* **(*E*)Nginx**, it is the server and entrypoint
* ***M*ariaDB**, for the database
* **Wordpress** (with ***P*HP**), to host the website and have admin access

Each services run in their respective, separate, containers and us a Docker network to communicate.

There are two volumes set up to keep persistent datas. One to store MariaDB database and the other to keep webpages for the website, so linked to Wordpress.

## Prerequisites

Before setting up the project, make sure the following tools are installed:

* Docker
* Docker Compose
* GNU Make
* Sudo

Check the installed versions with:

```bash
docker --version
docker compose version
make --version
sudo --version
```

## Environment Configuration

Before building the project, create the environment file:

```text
srcs/.env
```

Use the following template, adding value to each variable:

<!-- TODO: check .env -->
```env
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

The `.env` file contains sensitive information, including database and WordPress credentials.

It must **not be committed to Git** or shared publicly.

Make sure it is included in `.gitignore`:

```gitignore
srcs/.env
```

## Building and Launching the Project

The simplest way to build and launch the complete stack is:

```bash
make
```

This command:

1. Creates the directories required for persistent data.
2. Builds the Docker images.
3. Creates the required Docker volumes.
4. Creates the Docker network.
5. Starts the containers.

To launch the stack in detached mode:

```bash
make up
```

## Using the Makefile

* To display every information about the Docker environment:

```bash
make check
```

This will display all the containers, images, volumes abd networks.

* To start the containers:

```bash
make start
```

* To stop the containers:

```bash
make stop
```

Stopping the containers should not delete its persistent data.

* To delete the containers:

```bash
make down
```

This stops and removes the containers and network.

The persistent volumes are kept.

* To clean the project:

```bash
make fclean
```

This stops and delete the containers, removes volumes and network.

Persistent data are deleted.

* To prune the cache:

```bash
make prune
```

* To clean and restart

```bash
make re
```

This combines ``make fclean`` and ``make up``, so the containers will be run in detach mode.

### View logs

To inspect the logs of a specific container:

```bash
docker logs <container_name>
```

Each container is named by the service name in lower case, so use:

```bash
docker logs nginx
docker logs wordpress
docker logs mariadb
```

When using Docker Compose, logs for all services can be viewed with:

```bash
docker compose -f srcs/docker-compose.yml logs
```

Add a container's name at the end to get its specific logs.

## Interact with container

To check something inside a container us:

```bash
docker exec -it <container_name> <command>
```

Replace `<command>` with `bash` to enter the container and do multiple commands.

## Data Persistence

The exact volume names and host locations are defined by the Docker Compose configuration.

Change the path defined after ``device`` for each volume in the `docker-compose.yml` file:

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

<!-- TODO: add certificates info (like .env) in case i find some motivate -->
