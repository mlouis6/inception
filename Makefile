PHONY: all fclean

COMPOSE = cd srcs && docker compose

all:
	$(COMPOSE) up

fclean:
	docker stop nginx wordpress
	docker rm nginx wordpress
	docker rmi srcs-nginx srcs-wordpress