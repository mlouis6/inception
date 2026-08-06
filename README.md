*This project has been created as part of the 42 curriculum by mlouis.*

# Description
Build images from scratch and run containers from them. Link them without specifiying using a network, so we'll only have nginx as an entrypoint for the whole app.

<!-- TODO: -->
Comparison between:
- Secrets vs Environment vars
- Docker Network vs Host Network
- Docker Volumes vs Bind Mounts
- Ochestrors

## Virtual Machines vs Docker
### Before VMs and Containers
Before VMs and containers were a thing, companies bought one server per application.
Since the need for applications weren't known before building, servers were often more powerful than needed
just in case, so resources were fully used.

### Virtual Machines
Virtual machines could divide hardware resources between multiple environment and a single server could now host many applications.
Each VM has its OS install, so many resources allocated per VM.

### Containers
Containers share a single kernel, and each container share some resources, quicker to boot and lighter.
Portability, Lightwight, Scalability and Security
Limitation: Linux environment are only for Linux container, Windows env, only for Windows containers, no Mac containers (or very limited)
(namespaces, cgroups, capabilities)

### Docker Engine
It's the software that allows the build and run containers.

### Docker Registry
It is use to host and distribute images. It's link with Docker Hub which use that a cloud implementation.

### Docker Swarm
It is an ochestrator. It makes working on and managing multiple containers easier. It also make scaling and security.

Usually, most people choose Kubernetes instead of Swarm, but for beginner, Swarm has an easier learning curve and it's installed with Docker. But it is meant for low maintenance stack.

#### Architecture
##### Docker daemon
Docker daemon is named dockerd. It manage the lifecycle of a container: creation, execution and monitoring. It links the client to the engine.

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
Using volumes allows datas to be persistently stored for containers. So as long as you don't delete the volume, you can remove the container, even the images, and create it back up with the same datas.

There are 3 types of volumes: bind, docker and named
<!-- TODO: explain the different kind of volumes --> 

### Secrets
with .env, if you push your image, it pushes the environment, so variables are readable
secrets gives you the ability to push images without pushing sensible informations
encrypted and only accessable by specific services

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
To check and go more in depth on some informations.



## Sources
Stéphane ROBERT

https://developer.wordpress.org/advanced-administration/

https://ubuntu.com/tutorials/install-and-configure-wordpress

https://www.digitalocean.com/community/tutorials/how-to-install-linux-nginx-mariadb-php-lemp-stack-on-debian-10
