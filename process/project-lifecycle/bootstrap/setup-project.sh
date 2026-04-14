#!/usr/bin/env bash
# setup-project.sh — AI-Lore bootstrap Part 1, Step B.
#
# Precondition: AI-Lore Upstream is already cloned at
# .ai-lore-<project_name>/upstream/core/ (unversioned staging path).
# Step A of bootstrap is a single git clone the caller runs themselves:
#
#   git clone --depth 1 https://github.com/alberto-conan-ui/ai-sdlc \
#     .ai-lore-<project_name>/upstream/core
#
# This script then sets up the project against the vendored Upstream:
#   1. Validate project_name is filesystem-safe
#   2. Validate no enclosing ancestor has a colliding .ai-lore-<project_name>/
#   3. Validate the requested plugin exists in upstream/core/plugins/
#   4. Capture core version from the cloned upstream's changelog
#   5. Rename upstream/core/ → upstream/core-<version>/ (version-pin the clone)
#   6. Establish the project root — git init if needed, write workspace.yaml,
#      write .gitignore
#   7. Run build-process.sh to stage the build at .ai-lore-<project_name>/dist/process/core-<version>/ and promote it to .ai-lore-<project_name>/process/
#
# After this script completes, Part 2 runs inside an AI session against the
# bootstrapped folder. The script prints the kickoff prompt at the end.
#
# Usage:
#   bash .ai-lore-<project_name>/upstream/core/process/project-lifecycle/bootstrap/setup-project.sh <project_name> <plugin_name>
#
# Environment override:
#   AI_LORE_CORE_VERSION  — explicit version string to write into workspace.yaml,
#                           bypassing changelog resolution.

set -euo pipefail

# -----------------------------------------------------------------------------
# Arguments
# -----------------------------------------------------------------------------

if [[ $# -lt 2 ]]; then
  cat >&2 <<'USAGE'
usage: bash setup-project.sh <project_name> <plugin_name>

  project_name   short identifier for the project. Becomes the last segment of
                 the Lore folder (.ai-lore-<project_name>/) — it is a real
                 directory name and must be filesystem-safe. Allowed characters:
                 [a-zA-Z0-9_-], must not start with a dot or hyphen.
  plugin_name    one of the plugins shipped with core (e.g. sdlc, spec, ttrpg)
USAGE
  exit 1
fi

PROJECT_NAME="$1"
PLUGIN="$2"
LORE_DIR=".ai-lore-${PROJECT_NAME}"

# -----------------------------------------------------------------------------
# Validate project_name
#
# The name becomes the last segment of the Lore folder. It has to be a valid
# directory segment on every filesystem we care about: no spaces, no slashes,
# no leading dot or hyphen, no shell specials.
# -----------------------------------------------------------------------------

if ! [[ "${PROJECT_NAME}" =~ ^[a-zA-Z0-9_][a-zA-Z0-9_-]*$ ]]; then
  cat >&2 <<USAGE
setup-project: invalid project_name '${PROJECT_NAME}'.

The project name becomes the last segment of the Lore folder:
  ${LORE_DIR}/

It must match ^[a-zA-Z0-9_][a-zA-Z0-9_-]*$ — letters, digits, underscore,
hyphen; must not start with a hyphen or dot. Pick a shorter, simpler name.
USAGE
  exit 1
fi

# -----------------------------------------------------------------------------
# Nesting uniqueness check
#
# Walk up from the current directory looking for an ancestor that already
# contains a .ai-lore-${PROJECT_NAME}/ directory. If found, refuse — the
# name collides with an enclosing project and Claude's path heuristics would
# resolve ambiguously between them. Suggest a more specific name.
# -----------------------------------------------------------------------------

CHECK_DIR="$(cd .. 2>/dev/null && pwd || true)"
while [[ -n "${CHECK_DIR}" && "${CHECK_DIR}" != "/" ]]; do
  if [[ -d "${CHECK_DIR}/${LORE_DIR}" ]]; then
    cat >&2 <<COLLISION
setup-project: name collision.

An ancestor directory already contains ${LORE_DIR}/:
  ${CHECK_DIR}/${LORE_DIR}

Two AI-Lore projects in the same ancestor chain must not share a name —
path resolution inside a nested session would be ambiguous. Pick a more
specific project_name and rerun.
COLLISION
    exit 1
  fi
  PARENT="$(cd "${CHECK_DIR}/.." 2>/dev/null && pwd || true)"
  if [[ "${PARENT}" == "${CHECK_DIR}" ]]; then
    break
  fi
  CHECK_DIR="${PARENT}"
done

# -----------------------------------------------------------------------------
# Upstream precondition
# -----------------------------------------------------------------------------

if [[ ! -d "${LORE_DIR}/upstream/core" ]]; then
  cat >&2 <<MISSING
setup-project: ${LORE_DIR}/upstream/core not found.

Step A of bootstrap is missing. From the project root, run:

  git clone --depth 1 https://github.com/alberto-conan-ui/ai-sdlc ${LORE_DIR}/upstream/core

Then re-run this script.
MISSING
  exit 1
fi

# -----------------------------------------------------------------------------
# Validate plugin
# -----------------------------------------------------------------------------

if [[ ! -d "${LORE_DIR}/upstream/core/process/plugins/${PLUGIN}" ]]; then
  echo "setup-project: plugin '${PLUGIN}' not found in upstream/core/process/plugins/" >&2
  if [[ -d "${LORE_DIR}/upstream/core/process/plugins" ]]; then
    echo "setup-project: available plugins:" >&2
    ls "${LORE_DIR}/upstream/core/process/plugins/" 2>/dev/null | sed 's/^/  - /' >&2
  fi
  exit 1
fi

# Resolve core version from the upstream changelog — the changelog is the source
# of truth. Pick the highest-numbered v*.md entry. Explicit override still wins
# (used by CI and verification runs). Fail loudly if neither resolves; no silent
# fallback to a poison value.
if [[ -n "${AI_LORE_CORE_VERSION:-}" ]]; then
  CORE_VERSION="$AI_LORE_CORE_VERSION"
else
  CHANGELOG_DIR="${LORE_DIR}/upstream/core/process/changelog"
  if [[ ! -d "$CHANGELOG_DIR" ]]; then
    echo "setup-project: ${CHANGELOG_DIR} not found — cannot resolve core version" >&2
    echo "setup-project: the upstream core must ship a changelog folder; set AI_LORE_CORE_VERSION to override" >&2
    exit 1
  fi
  # Versions can live as flat files (legacy: v0.3.md) or as folders
  # (current convention from v0.4: changelog/v0.4/ containing v0.4.index.md
  # and any migration playbooks). Union both and take the sort-V highest.
  CORE_VERSION=$(
    {
      find "$CHANGELOG_DIR" -maxdepth 1 -type f -name 'v[0-9]*.md' -exec basename {} .md \; 2>/dev/null
      find "$CHANGELOG_DIR" -maxdepth 1 -type d -name 'v[0-9]*' -exec basename {} \; 2>/dev/null
    } | sort -V -u | tail -1
  )
  if [[ -z "$CORE_VERSION" ]]; then
    echo "setup-project: ${CHANGELOG_DIR} contains no v[0-9]* entries — cannot resolve core version" >&2
    echo "setup-project: set AI_LORE_CORE_VERSION to override" >&2
    exit 1
  fi
fi

# -----------------------------------------------------------------------------
# Version-pin the upstream clone
# -----------------------------------------------------------------------------

# The caller cloned into upstream/core/ as a staging path. Rename to
# upstream/core-<version>/ now that the version is resolved. From this point
# on, Upstream is always versioned — build-process.sh, Migrator, and every
# path template assume this shape.
VERSIONED_UPSTREAM="${LORE_DIR}/upstream/core-${CORE_VERSION}"
if [[ -d "${VERSIONED_UPSTREAM}" ]]; then
  echo "setup-project: ${VERSIONED_UPSTREAM} already exists — refusing to overwrite" >&2
  exit 1
fi
mv "${LORE_DIR}/upstream/core" "${VERSIONED_UPSTREAM}"

# -----------------------------------------------------------------------------
# Establish project root
# -----------------------------------------------------------------------------

# git init project root if not already its own git repo. AI-Lore assumes the
# project root is a git repo at its own level; any parent git that the project
# may live inside is fine but does not count.
if [[ "$(git rev-parse --show-toplevel 2>/dev/null)" != "$(pwd)" ]]; then
  echo "setup-project: initializing git at project root"
  git init -q
else
  echo "setup-project: project root is already a git repo"
fi

# workspace.yaml — the manifest read by build-process.sh and by sessions.
cat > "${LORE_DIR}/workspace.yaml" <<EOF
project_name: ${PROJECT_NAME}
core_version: "${CORE_VERSION}"
plugin: ${PLUGIN}
EOF

# .gitignore — ignore everything under the Lore folder except workspace.yaml,
# and ignore the root ai_readme.md since it is a build output installed in
# Part 2. Append if a .gitignore already exists, create fresh otherwise.
GITIGNORE_MARKER="# AI-Lore (${LORE_DIR})"
if [[ -f .gitignore ]] && grep -qF "${GITIGNORE_MARKER}" .gitignore; then
  echo "setup-project: .gitignore already contains AI-Lore entries for ${LORE_DIR}, leaving as-is"
else
  {
    [[ -f .gitignore ]] && echo ""
    echo "${GITIGNORE_MARKER}"
    echo "${LORE_DIR}/*"
    echo "!${LORE_DIR}/workspace.yaml"
    echo "ai_readme.md"
  } >> .gitignore
fi

# -----------------------------------------------------------------------------
# Build
# -----------------------------------------------------------------------------

bash "${VERSIONED_UPSTREAM}/process/project-lifecycle/build/build-process.sh"

# -----------------------------------------------------------------------------
# Hand-off
# -----------------------------------------------------------------------------

cat <<HANDOFF

setup-project: Part 1 complete.
setup-project:
setup-project:   Project root is a git repo, ${LORE_DIR}/workspace.yaml is written,
setup-project:   Upstream vendored at ${VERSIONED_UPSTREAM}, Process composed at
setup-project:   ${LORE_DIR}/process, .gitignore in place.
setup-project:
setup-project: Part 2 runs inside an AI session. Open an AI assistant with this
setup-project: folder as the working directory and paste:
setup-project:
setup-project:     Read ${LORE_DIR}/process/project-lifecycle/bootstrap/ai_readme-bootstrap.md and follow its instructions.
setup-project:
setup-project: Migrator will initialize Memory, seed the blueprint, capture project
setup-project: context, and install the root ai_readme.md as the closing move of Part 2.
HANDOFF
