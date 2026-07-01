TOOLKIT_DIR := $(shell cd "$(dir $(lastword $(MAKEFILE_LIST)))" && pwd)
PARENT_DIR := $(shell dirname "$(TOOLKIT_DIR)")

.PHONY: help new-workspace

help: ## Show available commands
	@echo ""
	@echo "Agentic Toolkit"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'
	@echo ""

new-workspace: ## Create a new dev-context workspace (name= required, context= optional)
ifndef name
	$(error Usage: make new-workspace name=personal-dev-context context="Personal side projects")
endif
	@./scripts/bootstrap-workspace.sh $(name) "$(context)"
