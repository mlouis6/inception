*This project has been created as part of the 42 curriculum by mlouis.*

# Description
Docker usage
Sources included in project
Indicate main design choices
Comparison between:
	VM vs Docker
	Secrets vs Environment vars
	Docker Network vs Host Network
	Docker Volumes vs Bind Mounts

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


# Instructions

# Resources

