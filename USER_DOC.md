Explain how user/admin can use the project
services provided
start and stop project
access website
access admin panel
locate and manage credentials
check that services are correctly running

# What is it
This is a web stack using 3 containers:
- nginx: used for the server
- mariadb: used to store and manage datas
- wordpress: used to display and manage website

# How to use
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

Then, a simple `make` command can be use to build all images and run the containers. 

Finally, the user will just have to open the browser of its choice and go to https://mlouis.42.fr.

If the user prefer to launch in detach mode, the use of `make up` is recommended.

To start and stop containers, use the commands `make start` and `make stop`.

The command `make down` can be use to stop and remove the containers. It will also delete the network.

To also remove the images and the volumes, the user can do `make fclean`.

To get rid of cache, use `make prune`

In case the user want to check anything `make check` can help and display any informations for containers, with their health status, to network.

To log on the website, access https://mlouis.42.fr/wp-admin. The user can use the admin username and password from their `.env` file (`USER_ADMIN` and `PASSWORD_ADMIN`) if they want to manage the website or the other credentials (`USER_ONE` and `PASSWORD_ONE`) to be a lambda user and be able to comment.


------
# User Documentation

## What is it?

This project is a small web stack made up of three containers:

* **Nginx** — acts as the web server and entry point for the application.
* **WordPress** — provides the website and its administration interface.
* **MariaDB** — stores and manages the WordPress database.

The containers communicate with each other through a private Docker network. Nginx is the entry point that receives requests from the user and forwards them to WordPress.

## Getting Started

### 1. Configure the environment

Before starting the project, create an `.env` file inside the `srcs/` directory.

Use the following template and replace the empty values with your desired credentials and configuration:

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

### 2. Start the project

Run:

```bash
make
```

This builds the Docker images, creates the required volumes and network, and starts the containers.

To start the project in detached mode, use:

```bash
make up
```

With detached mode, the containers continue running in the background and the terminal remains available for other commands.

## Stopping the Project

### Stop the containers

To stop the containers without removing them:

```bash
make stop
```

The containers can later be started again with:

```bash
make start
```

### Stop and remove the containers

To stop and remove the containers and their Docker network:

```bash
make down
```

The persistent volume data is not removed by this command.

### Complete cleanup

To remove the containers, network, images, and stored volume data:

```bash
make fclean
```

> **Warning:** `make fclean` deletes the directories containing the persistent data. Any data stored there may be permanently lost.

### Remove Docker cache

To remove Docker build/cache data:

```bash
make prune
```

## Accessing the Website

Once the containers are running, open a web browser and visit:

**https://mlouis.42.fr**

Nginx acts as the public entry point and forwards requests to the WordPress container.

If the website does not load, first check that all containers are running correctly with:

```bash
make check
```

## Accessing the Administration Panel

The WordPress administration panel is available at:

**https://banana.42.fr/wp-admin**

Use the administrator credentials defined in your `.env` file:

* **Username:** `USER_ADMIN`
* **Password:** `PASSWORD_ADMIN`
* **Email:** `EMAIL_ADMIN`

The administrator account can be used to manage the WordPress website, including its content and settings.

A regular WordPress user can use:

* **Username:** `USER_ONE`
* **Password:** `PASSWORD_ONE`
* **Email:** `EMAIL_ONE`

The regular user account does not have administrator privileges and can be used for normal website interactions, such as commenting.

## Managing Credentials

Credentials are configured through the `.env` file located in the `srcs/` directory.

The main credentials are:

| Variable                | Purpose                             |
| ----------------------- | ----------------------------------- |
| `WORDPRESS_DB_HOST`     | Database hostname used by WordPress |
| `WORDPRESS_DB_NAME`     | WordPress database name             |
| `WORDPRESS_DB_USER`     | WordPress database user             |
| `WORDPRESS_DB_PASSWORD` | WordPress database password         |
| `MYSQL_DATABASE`        | MariaDB database name               |
| `MYSQL_USER`            | MariaDB user                        |
| `MYSQL_PASSWORD`        | MariaDB user password               |
| `USER_ADMIN`            | WordPress administrator username    |
| `PASSWORD_ADMIN`        | WordPress administrator password    |
| `EMAIL_ADMIN`           | WordPress administrator email       |
| `USER_ONE`              | Regular WordPress username          |
| `PASSWORD_ONE`          | Regular WordPress password          |
| `EMAIL_ONE`             | Regular WordPress email             |

### Important

The `.env` file contains sensitive information and should **not be committed to Git or shared publicly**.

If a password needs to be changed, update the appropriate configuration and follow the project's setup procedure. Changing a credential that has already been stored in the database may require additional database or WordPress administration steps.

## Checking the Services

To check the current state of the Docker components, run:

```bash
make check
```

This displays information about the project's:

* **Containers** — whether they are running and their health status.
* **Images** — the Docker images used by the project.
* **Volumes** — persistent storage used by the services.
* **Network** — the Docker network connecting the containers.

You can also check the running containers directly with:

```bash
docker ps
```

A correctly running stack should have the **Nginx**, **WordPress**, and **MariaDB** containers running.

If a service is not running, check its logs with:

```bash
docker logs <container_name>
```

For example:

```bash
docker logs nginx
```

The exact container names may vary depending on the Docker Compose configuration.


