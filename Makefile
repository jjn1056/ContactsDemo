#
# makefile to help find your way around
#

PID_FILE := /var/contacts_demo_app.pid

help:
	@echo ""
	@echo "==> Manage Demo Application"
	@echo "update_cpanlib   Install CPAN libs"		
	@echo "update_db        Deploy Sqitch"
	@echo "update           (both above)"
	@echo "server           Start demo application server"
	@echo "hup              Restart demo application server"
	@echo "dependencies     List (most) CPAN dependencies"
	@echo ""
	@echo "==> Manage Containers"
	@echo "up               Start containers"
	@echo "stop             Stop containers"
	@echo "restart          Restart containers"
	@echo "build            Rebuild containers"
	@echo ""
	@echo "==> Container internal Commands"
	@echo "app-shell        Open a shell in the app container"
	@echo "db-shell         Open a shell in the db container"
	@echo "db-psql          Open a psql shell in the db container"
	@echo "app-update       'make update' inside the app container"
	@echo "app-hup          'make hup' inside the app container"
	@echo "app-restart      'make update & make hup' inside the app container"
	@echo "app-prove        'prove' inside the app container"
	@echo ""

# local application commands.  This should run where the Catalyst app is installed

update_cpanlib:
	@echo "Installing CPAN libs"
	@cpanm --notest --installdeps .

update_db:
	@echo "Running database migrations"
	@env PGHOST=$(DB_HOST) PGPORT=$(DB_PORT) PGPASSWORD=$(POSTGRES_PASSWORD) \
	 PGUSER=$(POSTGRES_USER) PGDATABASE=$(POSTGRES_DB) sqitch deploy

update: update_db update_cpanlib 

server: update
	@echo "Starting demo application"
	@start_server --port 5000 --pid-file=$(PID_FILE) -- \
		perl -Ilib \
		./lib/ContactsDemo/PSGI.pm run \
		--server Gazelle --max-workers 3 --max-reqs-per-child 1000 --min-reqs-per-child 800

hup:
	@kill -HUP $$(cat $(PID_FILE));

server-stop:
	@kill $$(cat $(PID_FILE));


dependencies:
	@ack '^use ' -h --nobreak | perl -nle'++$lines{$_}; END { print for sort grep $lines{$_}==1, keys %lines; }

# Start, Stop and Restart the docker containers

up: 
	@docker-compose up -d

stop:
	@docker-compose stop

restart: stop up

# Rebuild the docker image

build:
	@docker-compose build

# Run a shell or commands in the docker containers

app-shell:
	@docker-compose exec app_contacts bash

app-update:
	@docker-compose exec app_contacts make update

app-hup:
	@docker-compose exec app_contacts make hup

app-server-stop:
	@docker-compose exec app_contacts make server-stop

app-server:
	@docker-compose exec app_contacts make server

app-restart: app-update app-hup

db-psql:
	@docker-compose exec db_contacts psql -U contact_dbuser contacts

db-shell:
	@docker-compose exec db_contacts bash

app-prove:
	docker-compose exec app_contacts prove -lvr $(filter-out app-prove,$(MAKECMDGOALS))
