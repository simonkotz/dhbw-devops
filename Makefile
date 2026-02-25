.PHONY: all build test clean docker-build docker-push

GO_CMD = go
SERVICES := auth-service checkout-service product-service
DOCKER_REGISTRY ?= ghcr.io/simonkotz

all: build test

build:
	@for service in $(SERVICES); do \
		echo "Building $$service..."; \
		$(GO_CMD) build -o $$service/main ./$$service/cmd/main.go; \
	done

test:
	@for service in $(SERVICES); do \
		echo "Testing $$service..."; \
		cd $$service && $(GO_CMD) test -v ./... && cd ..; \
	done

clean:
	@for service in $(SERVICES); do \
		rm -f $$service/main; \
	done

docker-build:
	@for service in $(SERVICES); do \
		echo "Building Docker image for $$service..."; \
		docker build --build-arg SERVICE=$$service -t $(DOCKER_REGISTRY)/$$service:latest -f Dockerfile.alpine .; \
	done

docker-push:
	@for service in $(SERVICES); do \
		echo "Pushing Docker image for $$service..."; \
		docker push $(DOCKER_REGISTRY)/$$service:latest; \
	done
