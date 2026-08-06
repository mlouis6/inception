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
