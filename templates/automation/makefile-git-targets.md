# Makefile Git Targets

Copy these into your project's Makefile for a streamlined git workflow.

## Core Targets (Always Include)

```makefile
##@ Git & PR

branch: ## Create a new branch (name= required)
ifndef name
	$(error Usage: make branch name="{type}/PROJ-XXX-description")
endif
	git checkout development
	git pull
	git checkout -b $(name)

commit: ## Stage all, commit, and push (msg= required)
ifndef msg
	$(error Usage: make commit msg="{type}(PROJ-XXX): description")
endif
	git add .
	git commit -m "$(msg)"
	git push -u origin $$(git branch --show-current)

pr: ## Create a PR to development (title= required, body= optional)
ifndef title
	$(error Usage: make pr title="PROJ-XXX - Description" body="Summary")
endif
	gh pr create --base development --title "$(title)" --body "$(or $(body),No description provided)"
```

## AI Tracking Targets (Optional — Add Only When Tracking is Activated)

These targets are for projects that have opted into AI contribution tracking. See `templates/features/ai-contribution-tracking/` for the complete feature package.

**Do NOT include these by default.** Only add them when the team/project decides to track AI contributions.

```makefile
##@ AI Contribution Tracking (optional)

commit-kiro: ## Commit with AI co-author attribution (msg= required)
ifndef msg
	$(error Usage: make commit-kiro msg="{type}(PROJ-XXX): description")
endif
	git add .
	git commit -m "$(msg)" -m "Co-authored-by: Kiro AI <kiro-ai@users.noreply.github.com>"
	git push -u origin $$(git branch --show-current)

pr-kiro: ## Create a PR with kiro-generated label (title= required, body= optional)
ifndef title
	$(error Usage: make pr-kiro title="PROJ-XXX - Description" body="Summary")
endif
	gh pr create --base development --title "$(title)" --body "$(or $(body),No description provided)" --label "kiro-generated"
```

### Prerequisites for AI Tracking

- `kiro-generated` label created: `gh label create "kiro-generated" --description "PR generated via Kiro AI workflow" --color "7057ff"`

## Usage

```bash
# Standard workflow (always)
make branch name="feature/PROJ-001-add-auth"
make commit msg="feat(PROJ-001): add auth middleware"
make pr title="PROJ-001 - Add auth" body="feat: add auth middleware"

# AI tracking workflow (only when activated)
make commit-kiro msg="feat(PROJ-001): add auth middleware"
make pr-kiro title="PROJ-001 - Add auth" body="feat: add auth middleware"
```

## Customization

- Change `development` to `main` if that's your base branch
- Adjust the branch naming convention to match your project
- Add additional labels as needed (e.g., `--label "needs-review"`)
