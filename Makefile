.PHONY: all fclean up down

COMPOSE = docker compose -f srcs/docker-compose.yml

all:
	mkdir -p ~/data/wordpress/
	mkdir -p ~/data/mariadb/
	$(COMPOSE) up

up:
	mkdir -p ~/data/wordpress/
	mkdir -p ~/data/mariadb/
	$(COMPOSE) up -d

down:
	$(COMPOSE) down

fclean:
	$(COMPOSE) down --rmi local
	docker volume rm wp-vol db-vol
	docker network rm srcs_default

prune:
	docker builder prune -af
