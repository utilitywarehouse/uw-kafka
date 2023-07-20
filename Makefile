mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
base_dir := $(notdir $(patsubst %/,%,$(dir $(mkfile_path))))

SERVICE=account-paltform-kafka

DOCKER_REGISTRY?=registry.uw.systems
DOCKER_REPOSITORY_NAMESPACE?=account-platform
DOCKER_ID?=telco
DOCKER_REPOSITORY_IMAGE=$(SERVICE)
DOCKER_REPOSITORY=$(DOCKER_REGISTRY)/$(DOCKER_REPOSITORY_NAMESPACE)/$(DOCKER_REPOSITORY_IMAGE)

GIT_HASH := $(CIRCLE_SHA1)
ifeq ($(GIT_HASH),)
  GIT_HASH := $(shell git rev-parse HEAD)
endif

docker-image:
	docker build -t $(DOCKER_REPOSITORY):local . --build-arg SERVICE=$(SERVICE) --build-arg GITHUB_TOKEN=$(GITHUB_TOKEN)

ci-docker-auth:
	@echo "Logging in to $(DOCKER_REGISTRY) as $(DOCKER_ID)"
	@docker login -u $(DOCKER_ID) -p $(DOCKER_PASSWORD) $(DOCKER_REGISTRY)

ci-docker-build: ci-docker-auth
	docker build -t $(DOCKER_REPOSITORY):$(CIRCLE_SHA1) .
	docker tag $(DOCKER_REPOSITORY):$(CIRCLE_SHA1) $(DOCKER_REPOSITORY):latest
	docker push $(DOCKER_REPOSITORY)
