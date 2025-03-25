VERSION := $(or $(NETBOX_VERSION),master)

## help: print this help message
.PHONY: help
help:
	@echo 'Usage:'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'

netbox/.git:
	@git clone --single-branch --branch=${VERSION} https://github.com/netbox-community/netbox.git netbox/

## run: build and run the containers
.PHONY: run
run: netbox/.git
	@docker compose up --build

## restart: restart the containers
.PHONY: restart
restart:
	@docker compose restart

## rebuild: stop, rebuilt and start the containers
.PHONY: rebuild
rebuild: stop clean run

## stop: stop the containers
.PHONY: stop
stop:
	@docker compose down

## open: open netbox in the web browser (macos only)
.PHONY: open
open:
	@open http://localhost:8000

## clean: remove the local netbox clone, docker containers and associated volumes
.PHONY: clean
clean:
	@rm -rf netbox
	@docker compose down --volumes --rmi all

## migrations: create migrations, use PLUGIN=plugin_name to create migrations for a plugin
.PHONY: migrations
migrations:
	@docker compose exec netbox /opt/netbox/netbox/manage.py makemigrations ${PLUGIN}

## migrate: apply migrations
.PHONY: migrate
migrate:
	@docker compose exec netbox /opt/netbox/netbox/manage.py migrate

## nbshell: execute the netbox shell
.PHONY: nbshell
nbshell:
	@docker compose exec netbox /opt/netbox/netbox/manage.py nbshell

## dbshell: execute the postgres database shell
.PHONY: dbshell
dbshell:
	@docker compose exec netbox /opt/netbox/netbox/manage.py dbshell

