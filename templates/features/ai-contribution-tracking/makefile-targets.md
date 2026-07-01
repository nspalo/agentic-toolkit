# AI Contribution Tracking — Makefile Targets

Add these to your project's Makefile ONLY when AI contribution tracking is activated.

```makefile
##@ AI Contribution Tracking

commit-kiro: ## Commit as Kiro AI author (msg= required)
ifndef msg
	$(error Usage: make commit-kiro msg="type(PROJ-XXX): description")
endif
	git add .
	git commit --author="Kiro AI <kiro-ai@users.noreply.github.com>" -m "$(msg)"
	git push -u origin $$(git branch --show-current)

commit-assisted: ## Commit as human with Kiro co-author (msg= required)
ifndef msg
	$(error Usage: make commit-assisted msg="type(PROJ-XXX): description")
endif
	git add .
	git commit -m "$(msg)" -m "Co-authored-by: Kiro AI <kiro-ai@users.noreply.github.com>"
	git push -u origin $$(git branch --show-current)

pr-kiro: ## Create PR with kiro-generated label (title= required, body= optional)
ifndef title
	$(error Usage: make pr-kiro title="PROJ-XXX - Description" body="Summary")
endif
	gh pr create --base development --title "$(title)" --body "$(or $(body),No description provided)" --label "kiro-generated"
```

## Setup Required

Before first use:
```bash
gh label create "kiro-generated" --description "PR generated via Kiro AI workflow" --color "7057ff"
```

## Usage

```bash
# AI wrote the code, human reviewed
make commit-kiro msg="feat(PROJ-001): add auth middleware"

# Human wrote code, AI helped
make commit-assisted msg="fix(PROJ-002): correct date boundary"

# AI-driven PR
make pr-kiro title="PROJ-001 - Add auth" body="feat: add auth middleware"
```
