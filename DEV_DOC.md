Explain what dev can do
set up env from scratch
build and launch with Makefile and Docker Compose
commands to manage containers and volumes
identify where dats stored and how persists

to got into container
docker exec -it <CONNAME> bash

to check tls
curl -vk https://localhost
openssl s_client -connect localhost:443

to stop using localhost
  sudo nano /etc/hosts
   127.0.0.1 mlouis.42.fr
  change:
   nginx conf file: server_name mlouis.42.fr
   nginx dockerfile: -subj "/CN=mlouis.42.fr" 

volumes
/var/lib/docker/volumes/
docker volume create volume_name
or
docker run -v volume_name:/path/in/container

LEMP stack (Linux, Nginx, MariaDB, PHP)

-------
docker exec --it <CONTAINER_NAME> bash (bash can be replaced with another command if you only need one thing)

before build -> check path <!-- TODO: -->

directly logged as root

Dev will need to create a `.env` file in `srcs/` directory.
The `.env` file will need to define the following variables:
```
WORDPRESS_PORT
WORDPRESS_DB_HOST
WORDPRESS_DB_NAME
WORDPRESS_DB_USER
WORDPRESS_DB_PASSWORD

MYSQL_DATABASE
MYSQL_USER
MYSQL_PASSWORD

USER_ADMIN
PASSWORD_ADMIN
EMAIL_ADMIN
```

We've had a lambda user (no admin privileges in Wordpress) using thosw variables:
```
USER_ONE
PASSWORD_ONE
EMAIL_ONE
```


-----

# Developer Documentation

## Overview

This project is a Docker-based web stack composed of three services:

* **Nginx** — acts as the web server and entry point.
* **WordPress** — provides the website and administration interface.
* **MariaDB** — stores the WordPress database.

The services run in separate Docker containers and communicate through a private Docker network.

Persistent data is stored outside the containers using Docker volumes, allowing the containers to be removed and recreated without losing the application data.

## Prerequisites

Before setting up the project, make sure the following tools are installed:

* **Docker**
* **Docker Compose**
* **GNU Make**
* **Git**

Check the installed versions with:

```bash
docker --version
docker compose version
make --version
git --version
```

Docker Compose is used to define and run the multi-container application, while the Makefile provides convenient commands for common operations.

## Project Structure

The project is organized approximately as follows:

```text
.
├── Makefile
├── README.md
├── USER_DOC.md
├── DEV_DOC.md
└── srcs/
    ├── .env
    ├── docker-compose.yml
    └── requirements/
        ├── nginx/
        ├── wordpress/
        └── mariadb/
```

The exact structure may contain additional configuration or source files.

### `Makefile`

The Makefile provides shortcuts for building, starting, stopping, and cleaning the project.

### `srcs/docker-compose.yml`

The Docker Compose configuration defines the services, networks, volumes, environment variables, and other Docker configuration required by the stack.

### `srcs/requirements/`

This directory contains the configuration and Dockerfiles for each service:

* `nginx/`
* `wordpress/`
* `mariadb/`

## Environment Configuration

Before building the project, create the environment file:

```text
srcs/.env
```

Use the following template:

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

Replace each empty value with the appropriate configuration.

### Secrets

The `.env` file contains sensitive information, including database and WordPress credentials.

It must **not be committed to Git** or shared publicly.

Make sure it is included in `.gitignore`:

```gitignore
srcs/.env
```

For production environments, credentials should preferably be managed using a dedicated secrets-management solution rather than storing them directly in a local environment file.

## Building and Launching the Project

### Using the Makefile

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

The containers will run in the background.

### Using Docker Compose Directly

The project can also be managed without the Makefile.

From the project root, use:

```bash
docker compose -f srcs/docker-compose.yml up --build
```

To start the stack in detached mode:

```bash
docker compose -f srcs/docker-compose.yml up --build -d
```

To stop the stack:

```bash
docker compose -f srcs/docker-compose.yml down
```

Using the Makefile is recommended because it also handles project-specific directory and cleanup operations.

## Managing Containers

### List running containers

```bash
docker ps
```

To display all containers, including stopped ones:

```bash
docker ps -a
```

### Start stopped containers

Using the Makefile:

```bash
make start
```

Or with Docker:

```bash
docker compose -f srcs/docker-compose.yml start
```

### Stop containers

Using the Makefile:

```bash
make stop
```

Or with Docker Compose:

```bash
docker compose -f srcs/docker-compose.yml stop
```

Stopping a container does not remove it or its persistent data.

### Remove containers

```bash
make down
```

This stops and removes the project's containers and Docker network.

The persistent volumes are kept.

### View logs

To inspect the logs of a specific container:

```bash
docker logs <container_name>
```

For example:

```bash
docker logs nginx
docker logs wordpress
docker logs mariadb
```

When using Docker Compose, logs for all services can be viewed with:

```bash
docker compose -f srcs/docker-compose.yml logs
```

To follow logs in real time:

```bash
docker compose -f srcs/docker-compose.yml logs -f
```

## Managing Images

List the images currently available:

```bash
docker images
```

Images can be rebuilt with:

```bash
make
```

Or directly with Docker Compose:

```bash
docker compose -f srcs/docker-compose.yml build
```

To remove the project's containers and images as part of a complete cleanup:

```bash
make fclean
```

> **Warning:** `make fclean` also removes the project's persistent data directories. Do not use it if the stored data needs to be preserved.

## Managing Volumes

Docker volumes are used to keep data independent from the lifecycle of the containers.

List all Docker volumes:

```bash
docker volume ls
```

Inspect a volume:

```bash
docker volume inspect <volume_name>
```

The project uses persistent storage for data that must survive container recreation, particularly:

* WordPress files
* MariaDB database files

Removing a container does **not** remove its associated persistent volume when using the project's normal `make down` command.

## Data Persistence

Containers themselves should be considered disposable.

Application data is stored in persistent volumes instead of relying on the container's writable filesystem.

The general architecture is:

```text
                    Docker
                      │
          ┌───────────┼───────────┐
          │           │           │
       Nginx       WordPress    MariaDB
          │           │           │
          │           ▼           ▼
          │      WordPress     Database
          │        Volume        Volume
          │
          └──── Docker Network ────┘
```

The exact volume names and host locations are defined by the Docker Compose configuration.

### Host Data Directories

The project may use directories on the host as the source for persistent storage, depending on the Compose configuration.

These directories should **not be deleted manually** while the project is running.

If the project uses bind-mounted directories, their locations can be identified in:

```text
srcs/docker-compose.yml
```

Look for the `volumes:` sections of the WordPress and MariaDB services.

For Docker-managed named volumes, use:

```bash
docker volume inspect <volume_name>
```

to find where Docker stores the data on the host.

## Complete Cleanup

The following command performs a complete project cleanup:

```bash
make fclean
```

It removes:

* Running/stopped containers
* Docker network
* Project images
* Persistent volume data directories

Because persistent data is removed, this command should only be used when the data is no longer needed or has been backed up.

Docker's unused build/cache data can be cleaned separately with:

```bash
make prune
```

## Checking the Environment

The project provides a convenience command for checking the main Docker resources:

```bash
make check
```

This displays information about:

* Containers and their health status
* Docker images
* Docker volumes
* Docker networks

For more detailed troubleshooting, the following commands are useful:

```bash
docker ps -a
docker images
docker volume ls
docker network ls
docker compose -f srcs/docker-compose.yml logs
```

## Development Workflow

A typical development workflow is:

```text
1. Clone the repository
        │
        ▼
2. Create srcs/.env
        │
        ▼
3. Configure credentials
        │
        ▼
4. Run `make`
        │
        ▼
5. Check services with `make check`
        │
        ▼
6. Develop / modify configuration
        │
        ▼
7. Rebuild with `make`
```

When modifying a Dockerfile or service configuration, rebuild the affected image before testing the changes:

```bash
docker compose -f srcs/docker-compose.yml build
docker compose -f srcs/docker-compose.yml up
```

Keep persistent data separate from container configuration so that containers can be safely rebuilt without unnecessarily losing application or database data.

