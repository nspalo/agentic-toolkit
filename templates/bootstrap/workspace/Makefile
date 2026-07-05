TOOLKIT_PATH := ../agentic-toolkit

.PHONY: help project-new project-link project-list steering-generate steering-select

##@ Project Management

help: ## Show available commands
	@echo ""
	@echo "Workspace — Project & Steering Management"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'
	@echo ""

project-new: ## Scaffold a new project (name= required)
ifndef name
	$(error Usage: make project-new name=project-code)
endif
	@./scripts/bootstrap-project.sh $(name)

project-link: ## Scan a repo and pre-fill project context (name= repo= required)
ifndef name
	$(error Usage: make project-link name=project-code repo=/path/to/repo)
endif
ifndef repo
	$(error Usage: make project-link name=project-code repo=/path/to/repo)
endif
	@./scripts/link-project.sh $(name) $(repo)

project-list: ## List all project directories
	@echo "Projects:"
	@find ./projects -maxdepth 1 -type d ! -name 'projects' 2>/dev/null | sed 's|./projects/||' | sort | while read dir; do \
		if [ -f "./projects/$$dir/project-context.md" ]; then \
			echo "  projects/$$dir/ (has project-context.md)"; \
		fi; \
	done

##@ Steering

steering-generate: ## Generate steering files via AI detection (project= required)
ifndef project
	$(error Usage: make steering-generate project=beta)
endif
	@./scripts/scaffold-steering.sh $(project) generate

steering-select: ## Pick steering files from available templates (project= required)
ifndef project
	$(error Usage: make steering-select project=beta)
endif
	@./scripts/scaffold-steering.sh $(project) select
