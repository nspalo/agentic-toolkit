#!/bin/bash
set -e

WORKSPACE_NAME="$1"
WORKSPACE_CONTEXT="$2"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TOOLKIT_DIR="$(dirname "$SCRIPT_DIR")"
PARENT_DIR="$(dirname "$TOOLKIT_DIR")"
WORKSPACE_DIR="${PARENT_DIR}/${WORKSPACE_NAME}"
TEMPLATE_DIR="${TOOLKIT_DIR}/templates/bootstrap/workspace"

# Default context if not provided
if [ -z "$WORKSPACE_CONTEXT" ]; then
    CLEAN_NAME=$(echo "$WORKSPACE_NAME" | sed 's/-dev-context$//')
    WORKSPACE_CONTEXT="${CLEAN_NAME} projects"
fi

if [ -z "$WORKSPACE_NAME" ]; then
    echo "Usage: $0 <workspace-name>"
    echo "Example: $0 personal-dev-context"
    echo ""
    echo "This creates a new dev-context repo alongside the toolkit:"
    echo "  ~/ai-workflow/${WORKSPACE_NAME}/"
    exit 1
fi

if [ -d "$WORKSPACE_DIR" ]; then
    echo "Error: '$WORKSPACE_NAME' already exists at $WORKSPACE_DIR"
    exit 1
fi

if [ ! -d "$TEMPLATE_DIR" ]; then
    echo "Error: Workspace template not found at $TEMPLATE_DIR"
    exit 1
fi

echo "Creating dev-context workspace: $WORKSPACE_NAME"
echo "  Template: $TEMPLATE_DIR"
echo "  Target: $WORKSPACE_DIR"
echo ""

# Create the directory
mkdir -p "$WORKSPACE_DIR"

# Copy workspace template
cp "$TEMPLATE_DIR/Makefile" "$WORKSPACE_DIR/Makefile"
cp "$TEMPLATE_DIR/README.md" "$WORKSPACE_DIR/README.md"
cp "$TEMPLATE_DIR/.gitignore" "$WORKSPACE_DIR/.gitignore"

# Copy .kiro/steering
mkdir -p "$WORKSPACE_DIR/.kiro/steering"
cp "$TEMPLATE_DIR/.kiro/steering/workspace-identity.md" "$WORKSPACE_DIR/.kiro/steering/workspace-identity.md"

# Copy scripts
mkdir -p "$WORKSPACE_DIR/scripts"
cp "$TEMPLATE_DIR/scripts/bootstrap-project.sh" "$WORKSPACE_DIR/scripts/bootstrap-project.sh"
cp "$TEMPLATE_DIR/scripts/link-project.sh" "$WORKSPACE_DIR/scripts/link-project.sh"
cp "$TEMPLATE_DIR/scripts/scaffold-steering.sh" "$WORKSPACE_DIR/scripts/scaffold-steering.sh"
chmod +x "$WORKSPACE_DIR/scripts/bootstrap-project.sh"
chmod +x "$WORKSPACE_DIR/scripts/link-project.sh"
chmod +x "$WORKSPACE_DIR/scripts/scaffold-steering.sh"

# Create projects directory
mkdir -p "$WORKSPACE_DIR/projects"

# Create domain-knowledge directory
mkdir -p "$WORKSPACE_DIR/domain-knowledge"
cat > "$WORKSPACE_DIR/domain-knowledge/README.md" << 'EOF'
# Domain Knowledge

Shared knowledge applicable across all projects in this workspace. This is the first place to check when you need information about how the company's systems work — regardless of which project you're working on.

## What Goes Here

- Business entity definitions (account types, contract types, lifecycle states)
- System-wide integration patterns (external APIs, billing, campaigns)
- Product/plan catalog and relationships
- Cross-cutting technical concepts (charge lifecycle, billing periods, multi-tenancy)

## What Does NOT Go Here

- Project-specific implementation details → `projects/X/documentation/`
- Lessons learned from a specific project → `projects/X/knowledge-base/`
- Source code → project repos
- Methodology/tooling → `agentic-toolkit/`

## Promotion Rule

When a project discovers knowledge that applies universally:
1. Save it in `projects/X/knowledge-base/` or `projects/X/documentation/` first
2. Once confirmed useful across projects, create a copy here
3. Reference from here in future projects

## Naming

Files use kebab-case: `topic-name.md`
EOF

# Replace placeholders in templates
sed -i "s/{{WORKSPACE_NAME}}/${WORKSPACE_NAME}/g" "$WORKSPACE_DIR/README.md"
sed -i "s/{{WORKSPACE_NAME}}/${WORKSPACE_NAME}/g" "$WORKSPACE_DIR/.kiro/steering/workspace-identity.md"
sed -i "s/{{CONTEXT.*}}/${WORKSPACE_CONTEXT}/g" "$WORKSPACE_DIR/.kiro/steering/workspace-identity.md"

# Initialize git
cd "$WORKSPACE_DIR"
git init
echo ""

echo "✅ Workspace '$WORKSPACE_NAME' created at $WORKSPACE_DIR"
echo ""
echo "Next steps:"
echo "  1. Add to your IDE workspace (alongside your project repo + agentic-toolkit)"
echo ""
echo "  2. Bootstrap your first project:"
echo "     cd $WORKSPACE_DIR"
echo "     make project-new name=project-code"
echo "     make project-link name=project-code repo=/path/to/code"
echo ""
echo "  3. (Optional) Generate steering files:"
echo "     make steering-generate project=project-code"
echo ""
echo "  4. Start a session and load the project:"
echo "     Say: \"Read projects/project-code/project-context.md\""
echo ""
echo "  (Optional) Set git identity (needed only before first commit):"
echo "     cd $WORKSPACE_DIR"
echo "     git config user.name \"Your Name\""
echo "     git config user.email \"your-email@example.com\""
echo ""
echo "  (Optional) Add git remote:"
echo "     git remote add origin git@github.com:account/repo.git"
