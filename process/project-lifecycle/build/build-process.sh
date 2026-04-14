#!/usr/bin/env bash
# build-process.sh — AI-Lore v0.4 build pipeline.
#
# Takes Upstream (${LORE_DIR}/upstream/core-<version>/ + the plugin named in
# ${LORE_DIR}/workspace.yaml) and produces the composed Process at
# ${LORE_DIR}/process/ plus the rendered ai_readme.md entry point inside it.
#
# Builds run in a staging area at ${LORE_DIR}/dist/process/core-<version>/
# and are promoted atomically with a final mv into ${LORE_DIR}/process/.
# dist/ is the project-wide convention for script-produced intermediate
# output; each tool claims its own namespace. Process builds live under
# dist/process/, keyed by the core_version being built.
#
# Run from the project root (the directory that contains the Lore folder).
# The Lore folder is uniquely named per project: .ai-lore-<project_name>/.
# This script discovers it by globbing, then self-verifies that the
# discovered directory matches .ai-lore-${project_name}.
#
# Upstream is versioned (so Migrator can read old and new pins side by side
# during migration). Process is single-version — it always holds exactly the
# currently-active build, with no version suffix — so sessions searching
# process/ never cross version boundaries. The core_version field in
# workspace.yaml selects which Upstream the build reads; the final mv
# swaps the new build into process/ as the atomic cutover.
#
# Invoked by:
#   - bootstrap Part 1 Step B (first install, via setup-project.sh)
#   - Migrator during version upgrades
#   - verification runs (build twice and byte-compare outputs)
#
# Authoritative semantics live in
#   ${UPSTREAM_DIR}/process/project-lifecycle/build/build-process.md
#
# This script's job is to execute those semantics deterministically.
# Same inputs → byte-identical outputs. No AI discretion, no flags.

set -euo pipefail

# -----------------------------------------------------------------------------
# Discover Lore folder
#
# There must be exactly one .ai-lore-*/ directory at the project root. Zero
# means bootstrap hasn't run. More than one means the project is in an
# inconsistent state and a human has to reconcile.
# -----------------------------------------------------------------------------

shopt -s nullglob
LORE_CANDIDATES=(.ai-lore-*/)
shopt -u nullglob

if [[ ${#LORE_CANDIDATES[@]} -eq 0 ]]; then
  echo "build-process: no .ai-lore-*/ directory at project root — run setup-project.sh first" >&2
  exit 1
fi
if [[ ${#LORE_CANDIDATES[@]} -gt 1 ]]; then
  echo "build-process: multiple .ai-lore-*/ directories at project root — inconsistent state, reconcile manually" >&2
  printf '  - %s\n' "${LORE_CANDIDATES[@]}" >&2
  exit 1
fi

LORE_DIR="${LORE_CANDIDATES[0]%/}"

# -----------------------------------------------------------------------------
# Preconditions
# -----------------------------------------------------------------------------

if [[ ! -f "${LORE_DIR}/workspace.yaml" ]]; then
  echo "build-process: ${LORE_DIR}/workspace.yaml not found" >&2
  exit 1
fi

PROJECT_NAME=$(awk '/^project_name:/ {print $2}' "${LORE_DIR}/workspace.yaml" | tr -d '"')
CORE_VERSION=$(awk '/^core_version:/ {print $2}' "${LORE_DIR}/workspace.yaml" | tr -d '"')
PLUGIN=$(awk '/^plugin:/ {print $2}' "${LORE_DIR}/workspace.yaml" | tr -d '"')

if [[ -z "${PROJECT_NAME}" ]]; then
  echo "build-process: workspace.yaml is missing project_name" >&2
  exit 1
fi
if [[ -z "${CORE_VERSION}" ]]; then
  echo "build-process: workspace.yaml is missing core_version" >&2
  exit 1
fi
if [[ -z "${PLUGIN}" ]]; then
  echo "build-process: workspace.yaml is missing plugin" >&2
  exit 1
fi

# Self-verify: the discovered directory name must match .ai-lore-${PROJECT_NAME}.
# Any mismatch means workspace.yaml disagrees with the folder name and the
# project is in an inconsistent state.
EXPECTED_LORE_DIR=".ai-lore-${PROJECT_NAME}"
if [[ "${LORE_DIR}" != "${EXPECTED_LORE_DIR}" ]]; then
  echo "build-process: Lore directory '${LORE_DIR}' does not match workspace.yaml project_name '${PROJECT_NAME}' (expected '${EXPECTED_LORE_DIR}')" >&2
  exit 1
fi

# Versioned Upstream; staged Process build in dist/; canonical Process is
# single-version at ${LORE_DIR}/process/. The build writes into dist/, then
# the last step moves dist/process/core-${CORE_VERSION}/ → process/.
UPSTREAM_DIR="${LORE_DIR}/upstream/core-${CORE_VERSION}"
DIST_DIR="${LORE_DIR}/dist/process/core-${CORE_VERSION}"
PROCESS_DIR="${LORE_DIR}/process"

if [[ ! -d "${UPSTREAM_DIR}/process" ]]; then
  echo "build-process: ${UPSTREAM_DIR}/process not found — Upstream not vendored at this version" >&2
  exit 1
fi

if [[ ! -d "${UPSTREAM_DIR}/process/plugins/${PLUGIN}" ]]; then
  echo "build-process: plugin '${PLUGIN}' not found in ${UPSTREAM_DIR}/process/plugins/" >&2
  exit 1
fi

# -----------------------------------------------------------------------------
# Step 1 — Base layer: copy core process verbatim, minus source-only folders.
#
# Source-only folders are excluded from dist — they exist in Upstream for
# tooling to consume, but sessions never load them at runtime:
#   - base-stances/      source material plugins compose stances from
#   - project-lifecycle/memory-skeleton/
#                        source material Part 2 Step 4 copies into Memory;
#                        reads from Upstream directly, never from dist
# -----------------------------------------------------------------------------

rm -rf "${DIST_DIR}"
mkdir -p "${DIST_DIR}"
rsync -a \
  --exclude=base-stances \
  --exclude=plugins \
  --exclude=project-lifecycle/bootstrap/memory-skeleton \
  --exclude=project-lifecycle/bootstrap/focus.template.md \
  "${UPSTREAM_DIR}/process/" "${DIST_DIR}/"

# -----------------------------------------------------------------------------
# Step 2 — Plugin overlay, excluding blueprint/ and changelog/.
#
# blueprint/ is consumed once by bootstrap Part 2 (copied into Memory) and is
# not composed into Process. changelog/ is Upstream metadata read on demand by
# Migrator during upgrades and is not composed either.
#
# Name collisions with protected stances (auditor, migrator) fail the build.
# -----------------------------------------------------------------------------

for protected in auditor.md migrator.md; do
  if [[ -f "${UPSTREAM_DIR}/process/plugins/${PLUGIN}/stances/${protected}" ]]; then
    echo "build-process: plugin '${PLUGIN}' ships ${protected}, which is a protected infrastructure stance and cannot be overridden" >&2
    exit 1
  fi
done

rsync -a \
  --exclude=blueprint \
  --exclude=changelog \
  "${UPSTREAM_DIR}/process/plugins/${PLUGIN}/" \
  "${DIST_DIR}/"

# -----------------------------------------------------------------------------
# Step 3 — Render the ai_readme entry point and substitute placeholders
#          tree-wide across the staged build in dist/.
#
# Three placeholders flow through the build:
#   {project_name}  — the short identifier from workspace.yaml
#   {lore_dir}      — the Lore folder name, e.g. .ai-lore-tmp
#   {upstream_dir}  — the versioned Upstream path, e.g. .ai-lore-tmp/upstream/core-0.4
#
# Process paths in substituted files use the literal string ${LORE_DIR}/process/
# because process/ is single-version and has no suffix. No {process_dir}
# placeholder is needed.
#
# Substitution is tree-wide: every .md file under ${DIST_DIR} is passed
# through sed, so any doc can carry a placeholder without an extra render
# step. Exceptions live in SED_EXCLUDES below — files that document the
# placeholders literally must not be substituted.
# -----------------------------------------------------------------------------

if [[ ! -f "${DIST_DIR}/ai-spine/ai_readme.template.md" ]]; then
  echo "build-process: ai_readme.template.md missing from ${DIST_DIR}/ai-spine/" >&2
  exit 1
fi

# Rename the template to its final entry-point name before the sweep, so the
# tree-wide pass substitutes it in place alongside every other file. The
# project-root install (step2.md Step 7) moves this file out of process/.
mv "${DIST_DIR}/ai-spine/ai_readme.template.md" \
   "${DIST_DIR}/ai_readme.md"

# Files excluded from the substitution sweep. These are documents that discuss
# the placeholders as literal strings; substituting inside them would corrupt
# the contract they describe. Paths are relative to ${DIST_DIR}.
SED_EXCLUDES=(
  "project-lifecycle/build/build-process.md"
  "project-lifecycle/bootstrap/bootstrap.index.md"
  "project-lifecycle/bootstrap/step2.md"
  "project-structure.md"
  "changelog"
)

# Build a find expression that skips the exclude list.
FIND_ARGS=("${DIST_DIR}" -type f -name '*.md')
for excl in "${SED_EXCLUDES[@]}"; do
  FIND_ARGS+=(-not -path "${DIST_DIR}/${excl}" -not -path "${DIST_DIR}/${excl}/*")
done

while IFS= read -r -d '' file; do
  sed -i.bak \
    -e "s|{project_name}|${PROJECT_NAME}|g" \
    -e "s|{upstream_dir}|${UPSTREAM_DIR}|g" \
    -e "s|{lore_dir}|${LORE_DIR}|g" \
    "${file}"
  rm -f "${file}.bak"
done < <(find "${FIND_ARGS[@]}" -print0)

# -----------------------------------------------------------------------------
# Step 4 — Atomic promotion: move the staged build into ${PROCESS_DIR}.
#
# process/ is single-version. Wipe any existing build and move the freshly
# composed dist tree into place. The old process/ is discarded — rollback
# is a rebuild from upstream/core-<old>/, not a copy of the previous dist.
# -----------------------------------------------------------------------------

rm -rf "${PROCESS_DIR}"
mkdir -p "$(dirname "${PROCESS_DIR}")"
mv "${DIST_DIR}" "${PROCESS_DIR}"

# Clean up the now-empty dist/process/ parent if nothing else lives there.
rmdir "${LORE_DIR}/dist/process" 2>/dev/null || true
rmdir "${LORE_DIR}/dist" 2>/dev/null || true

echo "build-process: composed ${PROCESS_DIR} for project '${PROJECT_NAME}' (core ${CORE_VERSION}) using plugin '${PLUGIN}'"
