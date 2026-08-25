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


----------

# Docker Infrastructure

## Description

Build Docker images from scratch and run containers from them.

The containers communicate with each other through Docker's networking capabilities without requiring each service to be publicly exposed. **Nginx acts as the main entry point for the application**, routing incoming requests to the appropriate services.

<!-- TODO:
- Compare secrets vs environment variables
- Compare Docker networks vs host networking
- Compare Docker volumes vs bind mounts
- Explain container orchestration
-->

## Virtual Machines vs. Docker

### Before Virtual Machines and Containers

Before virtualization and containerization became common, companies typically dedicated one physical server to each application.

Because the resource requirements of an application were not always known in advance, servers were often provisioned with more CPU, memory, and storage than necessary. This resulted in significant resource waste.

### Virtual Machines

Virtual machines made it possible to divide the resources of a physical server between multiple isolated environments.

Each VM runs its own operating system, including its own kernel. This provides strong isolation, but also introduces additional resource overhead because every VM needs its own OS and system processes.

### Containers

Containers provide process-level isolation while sharing the host operating system's kernel.

Compared with virtual machines, containers are generally:

* **Lightweight** — they do not require a complete guest OS.
* **Fast to start** — containers can usually start in seconds or less.
* **Portable** — the same image can be run consistently across compatible environments.
* **Scalable** — many containers can run on the same host.
* **Isolated** — Linux features such as namespaces, cgroups, and capabilities provide process and resource isolation.

Containers do have limitations. A container must be compatible with the host kernel. For example, Linux containers rely on a Linux kernel. Docker Desktop on macOS and Windows therefore uses a lightweight Linux VM to run Linux containers.

## Docker Engine

**Docker Engine** is the software platform used to build, run, and manage containers.

It consists of several components, including the Docker daemon, Docker CLI, images, containers, networks, and volumes.

### Docker Daemon

The Docker daemon, `dockerd`, is the background service responsible for managing Docker objects and the container lifecycle.

It handles operations such as:

* Creating and removing containers
* Starting and stopping containers
* Building images
* Managing networks
* Managing volumes

### Docker Client

The Docker client is the command-line interface used to interact with Docker.

For example:

```bash
docker build
docker run
docker ps
docker images
docker network
docker volume
```

The CLI communicates with the Docker daemon, which performs the requested operations.

### Docker Image

A Docker image is a read-only package containing everything required to create a container, such as:

* Application code
* Dependencies
* Libraries
* Configuration
* Filesystem contents
* Metadata describing how the container should run

A container is created from an image.

### Docker Registry

A Docker registry stores and distributes Docker images.

**Docker Hub** is a public registry commonly used to publish and retrieve images. Organizations can also run private registries to distribute images internally.

The typical workflow is:

```text
Dockerfile → Docker Image → Docker Registry → Container
```

### Docker Compose

Docker Compose is used to define and manage multi-container applications.

Instead of manually running multiple `docker` commands, services, networks, volumes, ports, and other configuration can be described in a single Compose file.

For example:

```text
compose.yml
    ├── nginx
    ├── application
    └── database
```

The whole application can then be managed as a single stack.

### Docker Network

Docker networking allows containers to communicate with each other.

Containers attached to the same Docker network can communicate using their service or container names rather than relying on hard-coded IP addresses.

For example:

```text
             ┌─────────┐
Internet ───►│  Nginx  │
             └────┬────┘
                  │
          Docker Network
                  │
          ┌───────┴───────┐
          ▼               ▼
     Application       Database
```

Only the services that need to be accessible from outside the Docker environment need to expose ports to the host.

## Docker Swarm

**Docker Swarm** is Docker's native container orchestration system.

An orchestrator manages containers across one or more machines and provides features such as:

* Service management
* Scaling
* Service discovery
* Load balancing
* Rolling updates
* Desired-state management

Docker Swarm is relatively simple to get started with because it is integrated into Docker Engine.

Kubernetes is more widely adopted for large-scale container orchestration, but Swarm can be a simpler option for learning orchestration or managing smaller environments.

## Volumes

Containers are ephemeral by default. Data stored inside a container's writable filesystem can be lost when the container is removed.

Volumes provide persistent storage that exists independently from the container.

For example:

```text
Container
    │
    ▼
Docker Volume
    │
    ▼
Persistent data
```

As long as the volume is not deleted, the data can survive the removal and recreation of the container.

### Types of Mounts

Docker commonly provides three types of mounts:

1. **Volumes** — managed by Docker and stored in Docker's storage area.
2. **Bind mounts** — map a specific directory or file from the host into a container.
3. **tmpfs mounts** — store data in the host's memory and do not persist to disk.

For this project, Docker-managed volumes are used to persist application data.

<!-- TODO: Explain the differences between volumes, bind mounts, and tmpfs mounts in more detail. -->

## Secrets and Environment Variables

Environment variables are commonly used to configure applications:

```yaml
environment:
  DATABASE_HOST: database
  DATABASE_USER: app
```

However, environment variables are not inherently secure. Sensitive values such as passwords or API keys should not be committed to source control or exposed unnecessarily.

A `.env` file can be useful for local configuration, but it should generally be excluded from Git when it contains sensitive information.

Docker secrets provide a mechanism for securely providing sensitive information to services. Secrets can be made available only to the services that require them instead of placing the values directly in an image or configuration file.

> **Important:** building an image does not automatically include your shell environment variables or `.env` file. Sensitive information becomes part of an image only if it is explicitly copied into it or embedded into an image layer.

<!-- TODO:
- Explain when to use environment variables
- Explain Docker secrets
- Explain why secrets should not be stored in Dockerfiles
-->

## Nginx as the Entry Point

Nginx is used as the public entry point of the application.

Instead of exposing every service directly to the host, Nginx receives external requests and forwards them to the appropriate container.

```text
                    Internet
                       │
                       ▼
                  ┌─────────┐
                  │  Nginx  │
                  └────┬────┘
                       │
              Docker Network
                       │
          ┌────────────┼────────────┐
          ▼            ▼            ▼
      Service A    Service B    Service C
```

This keeps internal services isolated from direct external access while providing a single entry point to the application.

## Makefile Commands

### `make`

Creates the directories required for persistent data, builds the Docker images, creates the required volumes and network, and starts the containers.

### `make up`

Performs the same setup as `make`, but starts the containers in detached mode.

### `make down`

Stops and removes the containers and removes the Docker network.

### `make start`

Starts previously stopped containers.

### `make stop`

Stops the running containers without removing them.

### `make fclean`

Performs a complete cleanup:

* Stops the containers
* Removes the containers
* Removes the Docker network
* Removes the Docker images
* Deletes the directories used to store persistent volume data

> **Warning:** deleting the volume directories permanently removes the stored data.

### `make prune`

Removes Docker build/cache data.

### `make check`

Displays information about the main Docker components used by the project:

* Containers
* Images
* Volumes
* Networks

## Useful Docker Concepts

This project is intended to provide practical experience with:

* Dockerfiles and image creation
* Containers and container lifecycle
* Docker Compose
* Docker networking
* Persistent storage
* Volumes and mounts
* Secrets and environment variables
* Reverse proxies with Nginx
* Container orchestration with Docker Swarm
