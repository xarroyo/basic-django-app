APP_NAME=djangoapp
COMMAND=docker-compose

PHONY += build
build:
	$(COMMAND) build

PHONY += up-d
up-d: build
	$(COMMAND) up -d

PHONY += up
up: build
	$(COMMAND) up

PHONY += down
down:
	$(COMMAND) down -v

PHONY += shell
shell:
	$(COMMAND) exec $(APP_NAME) pipenv shell

PHONY += config
config:
	$(COMMAND) config

PHONY += chown-src
chown-src:
	sudo chown $(shell id -u):$(shell id -g) -R src/

PHONY += clean
clean:
	echo "Cleaning"

PHONY += test
test:
	$(COMMAND) run --rm api pipenv run pytest

PHONY += test-watch
test-watch:
	$(COMMAND) run --rm api pipenv run pytest-watch

.PHONY: $(PHONY)
