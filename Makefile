.PHONY: all fclean up down

COMPOSE = docker compose -f srcs/docker-compose.yml

all:
	$(COMPOSE) up

up:
	$(COMPOSE) up -d

down:
	$(COMPOSE) down

clean:
	$(COMPOSE) down -v --rmi local

fclean:
	$(COMPOSE) down -v --rmi local
	docker builder prune -af
	