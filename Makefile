CONTAINER=kinesis-example
BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
TAG=$(CONTAINER):$(BRANCH)
LATEST=$(CONTAINER):latest

build:
	docker build . -t $(TAG)
	docker tag $(TAG) $(LATEST)