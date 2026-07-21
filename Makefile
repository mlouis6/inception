.PHONY: all fclean up down

COMPOSE = docker compose -f srcs/docker-compose.yml

all:
	$(COMPOSE) up

up:
	$(COMPOSE) up -d

down:
	$(COMPOSE) down

fclean:
	$(COMPOSE) down --rmi local
	docker volume rm wp-vol

prune:
	docker builder prune -af
