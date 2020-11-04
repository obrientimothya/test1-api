RUNNER = docker-compose run --rm
NODE_VERSION = 15.0.1-alpine3.12
COMMIT_SHA  := $(if $(CI_COMMIT_SHORT_SHA),$(CI_COMMIT_SHORT_SHA),$(shell git rev-parse --short HEAD))
APP_VERSION=$(shell NODE_VERSION=$(NODE_VERSION) docker-compose run --rm --entrypoint "" node node -p "require('./package.json').version")

test:
	echo $(APP_VERSION)
PHONY: test
