RUNNER = docker-compose run --rm
NODE_VERSION = 15.0.1-alpine3.12
COMMIT_SHA  := $(if $(CI_COMMIT_SHORT_SHA),$(CI_COMMIT_SHORT_SHA),$(shell git rev-parse --short HEAD))
APP_VERSION = node -p "require('./package.json').$(1)"

test:
	NODE_VERSION=$(NODE_VERSION) \
				 $(RUNNER) --entrypoint "" \
				 node \
				 node -v
PHONY: test
