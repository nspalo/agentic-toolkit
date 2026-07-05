TOOLKIT_DIR := $(shell cd "$(dir $(lastword $(MAKEFILE_LIST)))" && pwd)
PARENT_DIR := $(shell dirname "$(TOOLKIT_DIR)")

.PHONY: help workspace-new

help: ## Show available commands
	@echo ""
	@echo "Agentic Toolkit"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'
	@echo ""

workspace-new: ## Create a new dev-context workspace (name= required, about= optional)
ifndef name
	$(error Usage: make workspace-new name=personal-dev-context about="Personal side projects")
endif
	@./scripts/bootstrap-workspace.sh $(name) "$(about)"
