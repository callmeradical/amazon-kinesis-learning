CONTAINER=callmeradical/kinesis-example
BRANCH := $(shell git rev-parse --abbrev-ref HEAD)
TAG=$(CONTAINER):$(BRANCH)
LATEST=$(CONTAINER):latest

#this is rudimentary and should not be used wholesale
build:
	docker build . -t $(TAG)
	docker tag $(TAG) $(LATEST)