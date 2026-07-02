#!/bin/bash
set -e

PROJECT_NAME="$1"
REPO_PATH="$2"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(dirname "$SCRIPT_DIR")"
PROJECT_DIR="${ROOT_DIR}/projects/${PROJECT_NAME}"
CONTEXT_FILE="${PROJECT_DIR}/project-context.md"

if [ -z "$PROJECT_NAME" ] || [ -z "$REPO_PATH" ]; then
    echo "Usage: $0 <project-name> <path-to-repo>"
    echo "Example: $0 my-project /home/user/projects/my-project"
    exit 1
fi

if [ ! -d "$PROJECT_DIR" ]; then
    echo "Error: Project '$PROJECT_NAME' not found at $PROJECT_DIR"
    echo "Run 'make new-project name=$PROJECT_NAME' first."
    exit 1
fi

if [ ! -d "$REPO_PATH" ]; then
    echo "Error: Repo not found at $REPO_PATH"
    exit 1
fi

echo "Scanning project repo: $REPO_PATH"
echo "Updating context for: $PROJECT_NAME"
echo ""

# Detect tech stack
TECH_INFO=""
FRAMEWORK=""
LANGUAGE=""
DATABASE=""
BUILD_TOOL=""
TEST_TOOL=""
PACKAGE_MANAGER=""

# Determine if project uses a src/ subdirectory layout
APP_ROOT="$REPO_PATH"
if [ -f "$REPO_PATH/src/composer.json" ] || [ -f "$REPO_PATH/src/package.json" ]; then
    APP_ROOT="$REPO_PATH/src"
    TECH_INFO="${TECH_INFO}Layout: src/ subdirectory (app code under src/)\n"
fi

# PHP/Laravel detection
if [ -f "$APP_ROOT/composer.json" ]; then
    LANGUAGE="PHP"
    PACKAGE_MANAGER="Composer"
    if grep -q "laravel/framework" "$APP_ROOT/composer.json" 2>/dev/null; then
        FRAMEWORK="Laravel"
        LARAVEL_VER=$(grep -o '"laravel/framework": "[^"]*"' "$APP_ROOT/composer.json" | grep -o '[0-9]*\.' | head -1)
        FRAMEWORK="Laravel ${LARAVEL_VER}x"
    fi
    if grep -q "phpunit" "$APP_ROOT/composer.json" 2>/dev/null; then
        TEST_TOOL="PHPUnit"
    fi
    if grep -q "nuwave/lighthouse" "$APP_ROOT/composer.json" 2>/dev/null; then
        TECH_INFO="${TECH_INFO}API: GraphQL (Lighthouse)\n"
    fi
    # PHP version detection
    PHP_VER=$(grep -o '"php": "[^"]*"' "$APP_ROOT/composer.json" | grep -o '[0-9]\.[0-9]*' | head -1)
    if [ -n "$PHP_VER" ]; then
        TECH_INFO="${TECH_INFO}PHP Version: ${PHP_VER}+\n"
    fi
fi

# Node/JS detection
if [ -f "$APP_ROOT/package.json" ]; then
    if [ -z "$LANGUAGE" ]; then
        LANGUAGE="JavaScript/TypeScript"
    else
        TECH_INFO="${TECH_INFO}Frontend: JavaScript/TypeScript (package.json found)\n"
    fi
    if grep -q "\"vue\"" "$APP_ROOT/package.json" 2>/dev/null; then
        TECH_INFO="${TECH_INFO}Frontend Framework: Vue.js\n"
    fi
    if grep -q "\"react\"" "$APP_ROOT/package.json" 2>/dev/null; then
        TECH_INFO="${TECH_INFO}Frontend Framework: React\n"
    fi
    if grep -q "\"vite\"" "$APP_ROOT/package.json" 2>/dev/null; then
        BUILD_TOOL="Vite"
    elif grep -q "laravel-mix" "$APP_ROOT/package.json" 2>/dev/null; then
        BUILD_TOOL="Laravel Mix (Webpack)"
    elif grep -q "\"webpack\"" "$APP_ROOT/package.json" 2>/dev/null; then
        BUILD_TOOL="Webpack"
    fi
    if grep -q "\"vitest\"" "$APP_ROOT/package.json" 2>/dev/null; then
        TEST_TOOL="${TEST_TOOL:+$TEST_TOOL + }Vitest"
    elif grep -q "\"jest\"" "$APP_ROOT/package.json" 2>/dev/null; then
        TEST_TOOL="${TEST_TOOL:+$TEST_TOOL + }Jest"
    fi
    if grep -q "\"typescript\"" "$APP_ROOT/package.json" 2>/dev/null; then
        TECH_INFO="${TECH_INFO}TypeScript: Yes\n"
    fi
fi

# Docker detection
if [ -f "$REPO_PATH/docker-compose.yml" ] || [ -f "$REPO_PATH/docker/docker-compose.yml" ]; then
    TECH_INFO="${TECH_INFO}Infrastructure: Docker Compose\n"
fi

# Database detection (check both root and src/)
for ENV_FILE in "$REPO_PATH/.env.example" "$APP_ROOT/.env.example"; do
    if [ -f "$ENV_FILE" ] && [ -z "$DATABASE" ]; then
        if grep -q "DB_CONNECTION=mysql" "$ENV_FILE" 2>/dev/null; then
            DATABASE="MySQL"
        elif grep -q "DB_CONNECTION=pgsql" "$ENV_FILE" 2>/dev/null; then
            DATABASE="PostgreSQL"
        elif grep -q "DB_CONNECTION=sqlite" "$ENV_FILE" 2>/dev/null; then
            DATABASE="SQLite"
        fi
    fi
done

# Makefile detection
MAKEFILE_TARGETS=""
if [ -f "$REPO_PATH/Makefile" ]; then
    MAKEFILE_TARGETS=$(grep -E "^[a-zA-Z_-]+:.*##" "$REPO_PATH/Makefile" | head -10 | awk -F':.*##' '{printf "| `make %s` | %s |\n", $1, $2}')
fi

# Existing .kiro detection
HAS_KIRO="No"
if [ -d "$REPO_PATH/.kiro/steering" ]; then
    HAS_KIRO="Yes ($(ls "$REPO_PATH/.kiro/steering/"*.md 2>/dev/null | wc -l) steering files)"
fi

# Generate summary
echo "=== Detected ==="
echo "Language: ${LANGUAGE:-Unknown}"
echo "Framework: ${FRAMEWORK:-Unknown}"
echo "Database: ${DATABASE:-Unknown}"
echo "Build: ${BUILD_TOOL:-Unknown}"
echo "Testing: ${TEST_TOOL:-Unknown}"
echo "Existing .kiro/: $HAS_KIRO"
echo -e "$TECH_INFO"
echo ""

# Build key files list (avoid empty lines from failed conditionals)
KEY_FILES=""
if [ "$APP_ROOT" != "$REPO_PATH" ]; then
    APP_LABEL=" (in ${APP_ROOT#$REPO_PATH/}/)"
else
    APP_LABEL=""
fi
[ -f "$APP_ROOT/composer.json" ] && KEY_FILES="${KEY_FILES}- composer.json ✅${APP_LABEL}\n"
[ -f "$APP_ROOT/package.json" ] && KEY_FILES="${KEY_FILES}- package.json ✅${APP_LABEL}\n"
[ -f "$REPO_PATH/Makefile" ] && KEY_FILES="${KEY_FILES}- Makefile ✅\n"
[ -f "$REPO_PATH/docker-compose.yml" ] && KEY_FILES="${KEY_FILES}- docker-compose.yml ✅\n"
[ -d "$REPO_PATH/docker" ] && KEY_FILES="${KEY_FILES}- docker/ ✅\n"
[ -f "$REPO_PATH/.env.example" ] && KEY_FILES="${KEY_FILES}- .env.example ✅\n"
[ -f "$APP_ROOT/.env.example" ] && [ "$APP_ROOT" != "$REPO_PATH" ] && KEY_FILES="${KEY_FILES}- src/.env.example ✅\n"
[ -d "$REPO_PATH/.kiro" ] && KEY_FILES="${KEY_FILES}- .kiro/ ✅\n"
[ -f "$REPO_PATH/README.md" ] && KEY_FILES="${KEY_FILES}- README.md ✅\n"

# Build additional info (strip trailing empty lines)
ADDITIONAL_INFO=$(echo -e "$TECH_INFO" | sed '/^$/d' | sed 's/^/- /')

# Write discovered info to a detection file (AI can use this to fill context)
DETECTION_FILE="${PROJECT_DIR}/.detected-stack.md"
cat > "$DETECTION_FILE" << EOF
# Auto-Detected Project Stack

> Generated by \`make link-project\`. Use this to fill in \`project-context.md\` and steering templates.
> Delete this file after project-context.md is filled.

## Detected Info

| Component | Detected Value |
|---|---|
| Language | ${LANGUAGE:-Unknown} |
| Framework | ${FRAMEWORK:-Unknown} |
| Database | ${DATABASE:-Unknown} |
| Build Tool | ${BUILD_TOOL:-Unknown} |
| Testing | ${TEST_TOOL:-Unknown} |
| Package Manager | ${PACKAGE_MANAGER:-Unknown} |
| Existing .kiro/ | ${HAS_KIRO} |

## Additional

$(echo -e "$ADDITIONAL_INFO")

## Repo Path

\`$REPO_PATH\`

## Key Files Found

$(echo -e "$KEY_FILES")

## Makefile Targets (if found)

| Command | Description |
|---|---|
${MAKEFILE_TARGETS:-| — | No Makefile targets detected |}

## Next Steps

1. In a Kiro session, say: "Ingest ${PROJECT_NAME}"
2. Once ingestion completes (validation handshake output), delete this file (\`.detected-stack.md\`)
3. See \`agentic-toolkit/knowledge/getting-started.md\` for "During Work" guidance
EOF

echo "✅ Detection complete. Written to: $DETECTION_FILE"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Next: Ingest the project"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "  In your Kiro session, say:"
echo ""
echo "    Ingest ${PROJECT_NAME}"
echo ""
echo "  This will read the detected stack, fill project-context.md,"
echo "  customize steering files, and validate the workspace is ready."
echo ""
echo "  After ingestion: you're ready for spec-driven development."
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
