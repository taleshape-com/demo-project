PYTHON := python
VENV := .venv
PIP := $(VENV)/bin/pip
SHAPER := $(VENV)/bin/shaper
SHAPER_VERSION ?= 0.12.5

.PHONY: install
install: ## Create venv (if needed) and install pinned shaper-bin
	test -d $(VENV) || $(PYTHON) -m venv $(VENV)
	$(PIP) install --upgrade "shaper-bin==$(SHAPER_VERSION)"

.PHONY: help
help: ## Show available make targets
	@grep -E '^[a-zA-Z0-9_-]+:.*##' $(firstword $(MAKEFILE_LIST)) | sort | \
		awk 'BEGIN {FS=":.*##"} {printf "%-10s %s\n", $$1, $$2}'

.PHONY: serve
serve: ## Run shaper server with local data dir
	$(SHAPER) -d .shaperdata

.PHONY: dev
dev: ## Run shaper dev
	$(SHAPER) -d .shaperdata dev

.PHONY: pull
pull: ## Run shaper pull
	$(SHAPER) -d .shaperdata pull

.PHONY: deploy
deploy: ## Run shaper deploy
	$(SHAPER) -d .shaperdata deploy
