VERSION := $(or $(NETBOX_VERSION),master)

## help: print this help message
.PHONY: help
help:
	@echo 'Usage:'
	@sed -n 's/^##//p' ${MAKEFILE_LIST} | column -t -s ':' |  sed -e 's/^/ /'

## build: build the container
.PHONY: build
build: netbox/.git
	@docker compose build

netbox/.git:
	@git clone --single-branch --branch=${VERSION} https://github.com/netbox-community/netbox.git netbox/

## update: update the netbox git repo
.PHONY: update
update: netbox/.github
	@cd netbox && git pull

## run: run the containers
.PHONY: run
run:
	@docker compose up

## restart: restart the containers
.PHONY: restart
restart:
	@docker compose restart

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

