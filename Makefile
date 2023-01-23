CONTAINER_NAME=ghcr.io/katexochen/sage-backend-gurobi/sage


.PHONY: build
build:
	DOCKER_BUILDKIT=1 docker build -t $(CONTAINER_NAME) -f Containerfile .

.PHONY: push
push:
	docker push $(CONTAINER_NAME):latest

