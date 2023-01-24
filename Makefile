CONTAINER_NAME     := "ghcr.io/katexochen/sage-backend-gurobi/sage"

DESCRIBE           := $(shell git describe --match "v*" --always --tags)
DESCRIBE_PARTS     := $(subst -, ,$(DESCRIBE))

PREV_VER           := $(word 1,$(DESCRIBE_PARTS))
COMMITS_SINCE_TAG  := $(word 2,$(DESCRIBE_PARTS))

PREV_VER_TAG       := $(shell git describe --abbrev=0 --tags)
PREV_VER           := $(subst v,,$(PREV_VER_TAG))
PREV_VER_PARTS     := $(subst ., ,$(PREV_VER))
PREV_MAJOR         := $(word 1,$(PREV_VER_PARTS))
PREV_MINOR         := $(word 2,$(PREV_VER_PARTS))
PREV_PATH          := $(word 3,$(PREV_VER_PARTS))

NEXT_PATCH         := $(shell echo $$(($(PREV_PATH)+1)))
NEXT_VER           := $(PREV_MAJOR).$(PREV_MINOR).$(NEXT_PATCH)
NEXT_VER_TAG       := "v$(NEXT_VER)"

.PHONY: build
build:
	DOCKER_BUILDKIT=1 docker build -t "$(CONTAINER_NAME):testing" -f Containerfile .

.PHONY: push
push:
ifneq ($(shell git diff --name-only),)
	@echo "Uncommitted changes, please commit before pushing"
else ifneq ($(shell git rev-parse --abbrev-ref HEAD), main)
	@echo "Not on main branch, please switch to main before pushing"
else ifeq ($(COMMITS_SINCE_TAG),)
	@echo "No new commits since last tag, nothing to push"
else
	@echo "New commits since last tag, releasing $(NEXT_VER_TAG)"
	DOCKER_BUILDKIT=1 docker build -t "$(CONTAINER_NAME):$(NEXT_VER)" -f Containerfile .
	docker image tag $(CONTAINER_NAME):$(NEXT_VER) $(CONTAINER_NAME):latest
	git tag -a $(NEXT_VER) -m "Release $(NEXT_VER)"
	git push
	git push origin $(NEXT_VER)
	docker push $(CONTAINER_NAME):$(NEXT_VER)
	docker push $(CONTAINER_NAME):latest
endif
