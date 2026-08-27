*This project has been created as part of the 42 curriculum by mlouis.*

# Description

Build images from scratch and run containers from them. Link them using a network, so Nginx will be the entrypoint for the whole app.

## Virtual Machines vs Docker

### Before VMs and Containers

Before VMs and containers were a thing, companies commonly bought one server per application.

Since the requirements needed for the application weren't known before building, servers were often more powerful than needed just in case, so resources were often wasted.

### Virtual Machines

Virtual machines could divide hardware resources between multiple environments and a single server could now host many applications with a strong isolation.

Each VM has its OS install, with its own kernel, so many resources allocated per VM.

### Containers

Containers share a single kernel, and each container share some resources, quicker to boot and lighter.

They are:
* **Portable**, a same image can be run on different machines, as long as the base kernel is similar
* **Lightweight**, they do not require a complete OS with its own kernel, so not as much data needed and that makes them faster
* **Scalable**, the same host can run many containers and a same project can easily puzzle together many containers
* **Isolated**, some Linux features (cgroups, namespace and capabilities), provides the containers some isolation

*Limitation:* Linux environment are only for Linux container, Windows env, only for Windows containers, no Mac containers (or very limited). Though, using Docker Desktop create a small Linux VM that make it possible to run Linux VM on Window and MacOS.

### Docker Engine

It's the software that allows the build and run containers.

### Docker Registry

It is use to host and distribute images. It's link with Docker Hub which use that a cloud implementation.

### Docker Swarm

It is an ochestrator. It makes working on and managing multiple containers easier. It also make scaling and security.

Usually, most people choose Kubernetes instead of Swarm, but for beginner, Swarm has an easier learning curve and it's installed with Docker. But it is meant for low maintenance stack.

#### Architecture

##### Docker daemon

Docker daemon is named `dockerd`. It manage the lifecycle of a container: creation, execution and monitoring. It links the client to the engine.

##### Docker client

It's a command line interface that allows the user to use all things docker.

##### Docker image

A Docker image is a package that includes all the necessary files and configuration to run a container.

##### Docker Compose

Docker Compose help run multi-container applications. It allows a unique configuration file to link all the Dockerfile and manage them all in a single command.

##### Docker network

Networking is used to give the ability for the containers to connect and communicate with each other.

### Docker vs Docker

### Volume

Using volumes allows data to be persistently stored for containers. So as long as the volume is not deleted, a container can be removed, even the image, and create it back up with the same data.

There are 3 types of volumes: bind, temp and named
* **Bind mounts** map a specific directory from the host into a container
* **Temp volumes** store the data in the host's memory and do not persist to disk
* **Named volumes** are managed by Docker, with a Docker defined storage area

### Secrets

Docker secrets securely provide information to services. Secrets are usually tied to only the services requiring them instead of being accessible directly in the image or a configuration file.

# Instructions

`make` create the directories where the volume will store its data, build the containers, create the volumes and the network, and finally run the images

`make up` same as make but in detach mode

`make down` stop the containers, remove them, remove the network

`make start` start the stopped containers

`make stop` stop the containers

`make fclean` stop the containers, remove them, remove the network, remove the images and delete the volume folder

`make prune` delete cache files

`make check` display main informations on each components (containers, images, volumes, network)

# Resources

## AI use

To check and go more in depth on some informations about Docker, check on best practices and catch some errors.

## Sources

<!-- Add sources -->

Stéphane ROBERT

https://developer.wordpress.org/advanced-administration/

https://ubuntu.com/tutorials/install-and-configure-wordpress

https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mariadb-php-lemp-stack-on-debian-10
