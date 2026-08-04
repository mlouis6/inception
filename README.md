*This project has been created as part of the 42 curriculum by mlouis.*

# Description
Goal
Build images from scratch and run containers from them. Link them without specifiying using a network, so we'll only have nginx as an entrypoint for the all app.


Docker usage

Sources included in project

Indicate main design choices

Comparison between:
- VM vs Docker
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

### Docker
Docker Engine
Docker Registry
Docker Swarm (now less used in favor of Kubernetes)

#### Architecture
Docker deamon
Docker client
Docker image
Docker Registry
Docker network
Docker Compose
Docker Swarm

### Docker vs Docker

### Volume

### Network

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
