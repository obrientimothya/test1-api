RUNNER = docker-compose run --rm
NODE_VERSION = 15.0.1-alpine3.12
COMMIT_SHA  := $(if $(CI_COMMIT_SHORT_SHA),$(CI_COMMIT_SHORT_SHA),$(shell git rev-parse --short HEAD))
APP_VERSION=$(shell NODE_VERSION=$(NODE_VERSION) docker-compose run --rm --entrypoint "" node node -p "require('./package.json').version")
IMAGE_NAME="testapi"

# run the API in a local
# docker container for testing
# and development
run: _npm
	NODE_VERSION=$(NODE_VERSION) \
	$(RUNNER) --service-ports --entrypoint "" \
	-e APP_VERSION=$(APP_VERSION) \
	-e COMMIT_SHA=$(COMMIT_SHA) \
	node \
	node app.js
PHONY: run

# run mocha tests
test: _npm
	NODE_VERSION=$(NODE_VERSION) \
	$(RUNNER) --service-ports --entrypoint "" \
	-e APP_VERSION=$(APP_VERSION) \
	-e COMMIT_SHA=$(COMMIT_SHA) \
	node \
	npm test
PHONY: test

build:
	docker build \
		-t $(IMAGE_NAME):latest \
		--build-arg NODE_VERSION=$(NODE_VERSION) \
		--build-arg APP_VERSION=$(APP_VERSION) \
		--build-arg COMMIT_SHA=$(COMMIT_SHA) \
	.
	docker tag $(IMAGE_NAME):latest $(IMAGE_NAME):$(APP_VERSION)-DEV
	docker tag $(IMAGE_NAME):latest $(IMAGE_NAME):$(APP_VERSION)
PHONY: build

# helpers

# run `npm install`
# in a local docker container
# for testing/dev
_npm:
	NODE_VERSION=$(NODE_VERSION) \
	$(RUNNER) --entrypoint "" node \
	npm install
PHONY: _install-local

# get a node shell
# for running custom developer
# commands
_shell:
	NODE_VERSION=$(NODE_VERSION) \
	$(RUNNER) --entrypoint "" node /bin/sh
PHONY: _shell
