.PHONY: setup build up down restart logs ps clean

setup:
	./setup.sh

build:
	cd frontend && npm install && npm run build
	docker compose build api

up:
	docker compose up -d

down:
	docker compose down

restart: down up

logs:
	docker compose logs -f

ps:
	docker compose ps

clean: down
	docker compose down -v
	rm -rf frontend/dist
