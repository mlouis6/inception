.PHONY: all fclean up down start stop prune check re

COMPOSE = docker compose -f srcs/docker-compose.yml

all:
	mkdir -p ~/data/wordpress/
	mkdir -p ~/data/mariadb/
	$(COMPOSE) up --build

up:
	mkdir -p ~/data/wordpress/
	mkdir -p ~/data/mariadb/
	$(COMPOSE) up -d --build

down:
	$(COMPOSE) down

start:
	$(COMPOSE) start

stop:
	$(COMPOSE) stop

check:
	docker ps -a
	docker images
	docker volume ls
	docker network ls

fclean:
	$(COMPOSE) down -v --rmi local
	sudo rm -rf ~/data/wordpress
	sudo rm -rf ~/data/mariadb
# 	rm -rf /Users/louism/prog/inception/data/mariadb
# 	mkdir /Users/louism/prog/inception/data/mariadb

# 	docker volume rm wp-vol db-vol
# 	docker network rm srcs_default

prune:
	docker builder prune -af

re:
	$(COMPOSE) down -v --rmi local
	sudo rm -rf ~/data/wordpress
	sudo rm -rf ~/data/mariadb
	mkdir -p ~/data/wordpress/
	mkdir -p ~/data/mariadb/
	$(COMPOSE) up -d
