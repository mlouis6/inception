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

LAMP stack (Apache instead of Nginx)