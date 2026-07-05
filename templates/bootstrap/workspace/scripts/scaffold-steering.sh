#!/bin/bash
set -e

PROJECT_NAME="$1"
MODE="$2"  # generate | select

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
TOOLKIT_PATH="${ROOT_DIR}/../agentic-toolkit"
PROJECT_DIR="${ROOT_DIR}/projects/${PROJECT_NAME}"
STEERING_DIR="${PROJECT_DIR}/.kiro-draft/steering"
REPO_PATH_FILE="${PROJECT_DIR}/.repo-path"

if [ -z "$PROJECT_NAME" ] || [ -z "$MODE" ]; then
    echo "Usage: $0 <project-name> <mode>"
    echo "Modes: generate | select"
    exit 1
fi

if [ ! -d "$PROJECT_DIR" ]; then
    echo "Error: Project '$PROJECT_NAME' not found at $PROJECT_DIR"
    echo "Run 'make project-new name=$PROJECT_NAME' first."
    exit 1
fi

if [ ! -f "$REPO_PATH_FILE" ]; then
    echo "Error: No linked repo found for '$PROJECT_NAME'."
    echo "Run 'make project-link name=$PROJECT_NAME repo=/path/to/repo' first."
    exit 1
fi

REPO_PATH=$(cat "$REPO_PATH_FILE")

if [ ! -d "$REPO_PATH" ]; then
    echo "Error: Linked repo path '$REPO_PATH' no longer exists."
    echo "Re-run 'make project-link name=$PROJECT_NAME repo=/path/to/repo' to update."
    exit 1
fi

if [ ! -d "$TOOLKIT_PATH/templates/steering" ]; then
    echo "Error: Toolkit steering templates not found at $TOOLKIT_PATH/templates/steering/"
    exit 1
fi

# Ensure steering directory exists
mkdir -p "$STEERING_DIR"

# Available steering templates
TEMPLATES=(
    "api-standards.md"
    "architecture-overview.md"
    "backend-patterns.md"
    "batch-execution-flow.md"
    "coding-standards.md"
    "database-standards.md"
    "fix-bug.md"
    "frontend-standards.md"
    "glossary.md"
    "multi-tenancy.md"
    "system-overview.md"
    "tech-stack.md"
    "troubleshooting.md"
)

# Also copy conventions and repository-map from bootstrap templates
BOOTSTRAP_TEMPLATES=(
    "conventions.md"
    "repository-map.md"
)

case "$MODE" in
    generate)
        echo "Steering Generation — AI-Assisted Mode"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""
        echo "  Project:  $PROJECT_NAME"
        echo "  Repo:     $REPO_PATH"
        echo "  Target:   $STEERING_DIR"
        echo ""

        # Copy all templates as a base for AI to work with
        for template in "${BOOTSTRAP_TEMPLATES[@]}"; do
            if [ -f "$TOOLKIT_PATH/templates/bootstrap/project/$template" ]; then
                cp "$TOOLKIT_PATH/templates/bootstrap/project/$template" "$STEERING_DIR/$template"
                sed -i "s/{{PROJECT_NAME}}/${PROJECT_NAME}/g" "$STEERING_DIR/$template"
            fi
        done

        for template in "${TEMPLATES[@]}"; do
            cp "$TOOLKIT_PATH/templates/steering/$template" "$STEERING_DIR/$template"
        done

        echo "✅ All steering templates copied to:"
        echo "   $STEERING_DIR"
        echo ""
        echo "Next step — in a Kiro session, say:"
        echo ""
        echo "   \"Generate steering files for $PROJECT_NAME."
        echo "    Scan the repo at $REPO_PATH, detect the stack,"
        echo "    and fill the templates in projects/$PROJECT_NAME/.kiro-draft/steering/."
        echo "    Remove any that aren't relevant to this project.\""
        echo ""
        echo "The AI will read the codebase, determine which files apply,"
        echo "fill them with real project content, and delete the rest."
        ;;

    select)
        echo "Steering Selection — Choose Templates"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo ""
        echo "  Project:  $PROJECT_NAME"
        echo "  Repo:     $REPO_PATH"
        echo ""
        echo "Available steering templates:"
        echo ""

        ALL_TEMPLATES=("${BOOTSTRAP_TEMPLATES[@]}" "${TEMPLATES[@]}")
        for i in "${!ALL_TEMPLATES[@]}"; do
            printf "  %2d) %s\n" $((i + 1)) "${ALL_TEMPLATES[$i]}"
        done

        echo ""
        echo "Enter numbers separated by spaces (e.g., 1 3 5 7 11 12):"
        read -r SELECTIONS

        if [ -z "$SELECTIONS" ]; then
            echo "No selection made. Exiting."
            exit 0
        fi

        COPIED=0
        for num in $SELECTIONS; do
            idx=$((num - 1))
            if [ $idx -ge 0 ] && [ $idx -lt ${#ALL_TEMPLATES[@]} ]; then
                template="${ALL_TEMPLATES[$idx]}"
                # Check if it's a bootstrap template or steering template
                if [[ " ${BOOTSTRAP_TEMPLATES[*]} " =~ " ${template} " ]]; then
                    cp "$TOOLKIT_PATH/templates/bootstrap/project/$template" "$STEERING_DIR/$template"
                    sed -i "s/{{PROJECT_NAME}}/${PROJECT_NAME}/g" "$STEERING_DIR/$template"
                else
                    cp "$TOOLKIT_PATH/templates/steering/$template" "$STEERING_DIR/$template"
                fi
                echo "  ✓ $template"
                COPIED=$((COPIED + 1))
            fi
        done

        echo ""
        echo "✅ $COPIED steering templates copied to:"
        echo "   $STEERING_DIR"
        echo ""
        echo "Next step — in a Kiro session, say:"
        echo ""
        echo "   \"Fill the steering templates in projects/$PROJECT_NAME/.kiro-draft/steering/"
        echo "    based on the codebase at $REPO_PATH."
        echo "    Scan the repo, detect the stack, and fill with real project content.\""
        ;;

    *)
        echo "Error: Unknown mode '$MODE'"
        echo "Valid modes: generate | select"
        exit 1
        ;;
esac
