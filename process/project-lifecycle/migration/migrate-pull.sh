#!/usr/bin/env bash
# migrate-pull.sh — AI-Lore migration Part 1, Steps 1–3.
#
# Shallow-clones upstream/main into a scratch path, resolves the latest
# core_version from the clone's changelog, compares against the current pin
# in workspace.yaml, and — if newer — moves the clone into place at
# ${LORE_DIR}/upstream/core-<new_version>/.
#
# After this script completes, the old Upstream is still on disk and
# workspace.yaml has NOT been updated. The pin flip and rebuild happen in
# Step 5 of migration, driven by Migrator after the Human Lead confirms
# the changelog and the playbook at Steps 2 and 4.
#
# Invoked by Migrator during migration Part 1.
#
# Usage (run from the project root — the directory that contains the Lore
# folder):
#
#   bash {lore_dir}/upstream/core-<current>/process/project-lifecycle/migration/migrate-pull.sh
#
# Environment overrides:
#   AI_LORE_CORE_VERSION   — explicit version string to treat as "latest",
#                            bypassing changelog resolution on the clone.
#   AI_LORE_UPSTREAM_REPO  — repo URL to clone from. Defaults to the pinned
#                            public AI-Lore repo.
#
# Exit codes:
#   0 — clone staged successfully at upstream/core-<new>/ and new pin
#       differs from current pin. Migrator proceeds to Step 2 (confirm).
#   2 — current pin is already at the latest published version. Migrator
#       reports "already up to date" and exits the migration session.
#   1 — any failure (precondition, clone, validation, collision).

set -euo pipefail

AI_LORE_UPSTREAM_REPO="${AI_LORE_UPSTREAM_REPO:-https://github.com/alberto-conan-ui/ai-sdlc}"

# -----------------------------------------------------------------------------
# Discover Lore folder
# -----------------------------------------------------------------------------

shopt -s nullglob
LORE_CANDIDATES=(.ai-lore-*/)
shopt -u nullglob

if [[ ${#LORE_CANDIDATES[@]} -eq 0 ]]; then
  echo "migrate-pull: no .ai-lore-*/ directory at project root — nothing to migrate" >&2
  exit 1
fi
if [[ ${#LORE_CANDIDATES[@]} -gt 1 ]]; then
  echo "migrate-pull: multiple .ai-lore-*/ directories at project root — inconsistent state, reconcile manually" >&2
  printf '  - %s\n' "${LORE_CANDIDATES[@]}" >&2
  exit 1
fi

LORE_DIR="${LORE_CANDIDATES[0]%/}"

if [[ ! -f "${LORE_DIR}/workspace.yaml" ]]; then
  echo "migrate-pull: ${LORE_DIR}/workspace.yaml not found" >&2
  exit 1
fi

CURRENT_VERSION=$(awk '/^core_version:/ {print $2}' "${LORE_DIR}/workspace.yaml" | tr -d '"')
if [[ -z "${CURRENT_VERSION}" ]]; then
  echo "migrate-pull: workspace.yaml is missing core_version" >&2
  exit 1
fi

CURRENT_UPSTREAM="${LORE_DIR}/upstream/core-${CURRENT_VERSION}"
if [[ ! -d "${CURRENT_UPSTREAM}" ]]; then
  echo "migrate-pull: current Upstream at ${CURRENT_UPSTREAM} not found — project is inconsistent with its own workspace.yaml" >&2
  exit 1
fi

# -----------------------------------------------------------------------------
# Scratch clone
# -----------------------------------------------------------------------------

SCRATCH_DIR="${LORE_DIR}/upstream/.migrate-scratch"
rm -rf "${SCRATCH_DIR}"
mkdir -p "${SCRATCH_DIR}"

echo "migrate-pull: cloning ${AI_LORE_UPSTREAM_REPO} into scratch..."
git clone --depth 1 "${AI_LORE_UPSTREAM_REPO}" "${SCRATCH_DIR}" >/dev/null 2>&1

# -----------------------------------------------------------------------------
# Resolve the new version from the clone's changelog
# -----------------------------------------------------------------------------

if [[ -n "${AI_LORE_CORE_VERSION:-}" ]]; then
  NEW_VERSION="${AI_LORE_CORE_VERSION}"
else
  CHANGELOG_DIR="${SCRATCH_DIR}/process/changelog"
  if [[ ! -d "${CHANGELOG_DIR}" ]]; then
    echo "migrate-pull: ${CHANGELOG_DIR} not found — upstream clone has no changelog folder" >&2
    rm -rf "${SCRATCH_DIR}"
    exit 1
  fi
  # Versions can live as flat files (legacy: v0.3.md) or as folders
  # (current convention from v0.4: changelog/v0.4/). Union both and take
  # the sort-V highest.
  NEW_VERSION=$(
    {
      find "${CHANGELOG_DIR}" -maxdepth 1 -type f -name 'v[0-9]*.md' -exec basename {} .md \; 2>/dev/null
      find "${CHANGELOG_DIR}" -maxdepth 1 -type d -name 'v[0-9]*' -exec basename {} \; 2>/dev/null
    } | sort -V -u | tail -1
  )
  if [[ -z "${NEW_VERSION}" ]]; then
    echo "migrate-pull: ${CHANGELOG_DIR} contains no v[0-9]* entries — cannot resolve latest version" >&2
    rm -rf "${SCRATCH_DIR}"
    exit 1
  fi
fi

# -----------------------------------------------------------------------------
# Compare against current pin
# -----------------------------------------------------------------------------

if [[ "${NEW_VERSION}" == "${CURRENT_VERSION}" ]]; then
  echo "migrate-pull: current pin '${CURRENT_VERSION}' is already at the latest published version — nothing to migrate"
  rm -rf "${SCRATCH_DIR}"
  exit 2
fi

NEW_UPSTREAM="${LORE_DIR}/upstream/core-${NEW_VERSION}"
if [[ -d "${NEW_UPSTREAM}" ]]; then
  echo "migrate-pull: ${NEW_UPSTREAM} already exists — a previous migration attempt left state behind; reconcile manually" >&2
  rm -rf "${SCRATCH_DIR}"
  exit 1
fi

# -----------------------------------------------------------------------------
# Promote scratch clone into place
# -----------------------------------------------------------------------------

mv "${SCRATCH_DIR}" "${NEW_UPSTREAM}"

# -----------------------------------------------------------------------------
# Hand-off
# -----------------------------------------------------------------------------

cat <<HANDOFF

migrate-pull: new Upstream vendored.

migrate-pull:   current pin : ${CURRENT_VERSION}  (at ${CURRENT_UPSTREAM})
migrate-pull:   new pin     : ${NEW_VERSION}  (at ${NEW_UPSTREAM})

migrate-pull: workspace.yaml has NOT been updated. The pin flip and rebuild
migrate-pull: happen in Step 5 of migration, driven by Migrator after the
migrate-pull: Human Lead confirms the changelog (Step 2) and the migration
migrate-pull: playbook (Step 4).

migrate-pull: Next: Migrator reads
migrate-pull:   ${NEW_UPSTREAM}/process/changelog/${NEW_VERSION}/${NEW_VERSION}.index.md
migrate-pull: and presents the release notes to the Human Lead for the Step 2
migrate-pull: confirmation. The version-specific migration playbook (Step 4)
migrate-pull: lives alongside it at:
migrate-pull:   ${NEW_UPSTREAM}/process/changelog/${NEW_VERSION}/migration-from-${CURRENT_VERSION}.md
HANDOFF
