RUNNER = docker-compose run --rm
NODE_VERSION = 15.0.1-alpine3.12
COMMIT_SHA := $(if $(CI_COMMIT_SHORT_SHA),$(CI_COMMIT_SHORT_SHA),$(shell git rev-parse --short HEAD))
APP_VERSION=$(shell NODE_VERSION=$(NODE_VERSION) docker-compose run --rm --entrypoint "" node node -p "require('./package.json').version")
IMAGE_NAME="testapi"
REPLICAS ?= 3

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

deploy-dev: build
	# this doesnt really push to dockerhub (time was running out!)
	# however, would be a docker login with $DOCKER_TOKEN
	# then add any requried Tags, then `docker push`
	echo "pushing to docker hub DEV"
PHONY: deploy-dev

deploy-prod: build
	# again this would push to dockerhub in same
	# manner, except it will push a prod release Tag
	echo "pushing to docker hub PROD"
PHONY: deploy-prod

kube-deploy:
	kubectl apply -f kube/testapi-cm.yml
	kubectl apply -f kube/testapi-deploy.yml
	kubectl apply -f kube/testapi-service.yml
PHONY: kube-deploy

kube-scale:
	kubectl scale --replicas=$(REPLICAS) deployment/testapi
PHONY: kube-scale

kube-destroy:
	kubectl delete cm testapi-cm
	kubectl delete deploy testapi
	kubectl delete svc testapi-service
PHONY: kube-destroy

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
