# Bootstrap — Part 2

> Migrator-driven walkthrough for Part 2 of bootstrap. Runs inside a fresh AI session opened against the folder Part 1 produced, with Migrator loaded via [`ai_readme-bootstrap.md`](./ai_readme-bootstrap.md). Part 2 initializes Memory, seeds the blueprint, captures project context, verifies the result, and installs the project-root session entry point as its closing move. Routed to from [`bootstrap.index.md`](./bootstrap.index.md).

> **`{lore_dir}` and `{upstream_dir}` in this file.** Every bash block in this walkthrough begins by reading these paths from workspace discovery so the commands can reference the Lore folder and the versioned Upstream unambiguously. Do not hand-substitute the paths — use the `LORE_DIR` and `UPSTREAM_DIR` exports and `${LORE_DIR}`, `${UPSTREAM_DIR}` references verbatim. The active Process is always at `${LORE_DIR}/process/` — single-version, no suffix.

## Step 4 — Initialize Memory

The Memory folder tree ships as a conformant skeleton at `{upstream_dir}/process/project-lifecycle/bootstrap/memory-skeleton/`. Every folder in the skeleton already has its own `[folder-name].index.md` with reference headers and the References / Children navigation grammar, honoring [`tree-discipline.md`](../../memory/tree-discipline.md)'s index-per-folder rule uniformly. Step 4 copies the skeleton into place and substitutes the project name — no inline authoring, no improvising.

```bash
# Discover the Lore folder (exactly one .ai-lore-*/ at project root)
cd "$(git rev-parse --show-toplevel)"
LORE_DIR=$(printf '%s\n' .ai-lore-*/ | head -1)
LORE_DIR="${LORE_DIR%/}"
export LORE_DIR

# Resolve the versioned Upstream path from workspace.yaml
CORE_VERSION=$(awk '/^core_version:/ {print $2}' "${LORE_DIR}/workspace.yaml" | tr -d '"')
UPSTREAM_DIR="${LORE_DIR}/upstream/core-${CORE_VERSION}"
export CORE_VERSION UPSTREAM_DIR

# Copy the skeleton into ${LORE_DIR}/memory/
cp -r "${UPSTREAM_DIR}/process/project-lifecycle/bootstrap/memory-skeleton/." "${LORE_DIR}/memory/"

# Initialize Memory as its own git repository
(cd "${LORE_DIR}/memory" && git init -q)
```

After these commands, every folder under `${LORE_DIR}/memory/` has an index file and every file has a reference header. Placeholders like `{project_name}` are still in place — Step 5 copies the blueprint seed (which also carries placeholders), and a single substitution pass runs at the end of Step 5 over the combined tree so both the skeleton and the blueprint seed land with their placeholders resolved.

The only thing the skeleton does NOT create is `blueprint/` — that folder is populated by Step 5 from the plugin's blueprint seed, not from the skeleton.

## Step 5 — Seed the blueprint and substitute placeholders

```bash
cd "$(git rev-parse --show-toplevel)"
LORE_DIR=$(printf '%s\n' .ai-lore-*/ | head -1)
LORE_DIR="${LORE_DIR%/}"
export LORE_DIR

CORE_VERSION=$(awk '/^core_version:/ {print $2}' "${LORE_DIR}/workspace.yaml" | tr -d '"')
UPSTREAM_DIR="${LORE_DIR}/upstream/core-${CORE_VERSION}"
PLUGIN=$(awk '/^plugin:/ {print $2}' "${LORE_DIR}/workspace.yaml" | tr -d '"')

# Copy the plugin's blueprint seed into ${LORE_DIR}/memory/blueprint/
cp -r "${UPSTREAM_DIR}/process/plugins/${PLUGIN}/blueprint/." "${LORE_DIR}/memory/blueprint/"

# Substitute {project_name} across the whole Memory tree now that both the
# skeleton and the blueprint seed are in place. Running the sed pass here
# (rather than at the end of Step 4) catches placeholders in the blueprint
# seed that the earlier pass would have missed.
PROJECT_NAME=$(awk '/^project_name:/ {print $2}' "${LORE_DIR}/workspace.yaml" | tr -d '"')
find "${LORE_DIR}/memory" -type f -name '*.md' -exec sed -i.bak "s|{project_name}|${PROJECT_NAME}|g" {} \;
find "${LORE_DIR}/memory" -name '*.bak' -delete
```

One-time operation. Subsequent builds never re-copy the blueprint. The `{project_overview}` placeholder in the KT index is intentionally left in place — Step 6 fills it with the captured overview. Note: `blueprint/` is a top-level child of `memory/`, not a branch of `knowledge-tree/` — see [`memory.index.md`](../../memory/memory.index.md).

## Step 6 — Capture project context

Three pieces of information about the project are captured and written into Memory. Migrator drives this step by asking the Human Lead for each piece and writing the answers into the pre-existing skeleton files from Step 4 — no files are created in this step, only filled in.

1. **What this project is** — one or two sentences describing the project. Replace the `{project_overview}` placeholder in `{lore_dir}/memory/knowledge-tree/knowledge-tree.index.md` with the captured sentence(s).
2. **The initial focus, if any** — if the project has a clear first goal, create a focus file at `{lore_dir}/memory/status/focus/<focus-name>.focus.md` by **copying** the focus template from `{upstream_dir}/process/project-lifecycle/bootstrap/focus.template.md` and substituting its three placeholders with the Human Lead's inputs:
   - `{focus_title}` — the H1 title of the focus, e.g. `bootstraptest — Audit the bootstrap`.
   - `{focus_gate}` — the concrete done-condition.
   - `{focus_context}` — a paragraph of background.

   The template ships the full four-field tracker shape (Gate, Context, Stack, Active child pointer, Journal trail) — do not improvise or drop sections. Use `sed -i.bak` with the three placeholder substitutions, exactly like Step 4 does for `{project_name}` on the memory skeleton. Then update `{lore_dir}/memory/status/status.index.md`'s Current state table to name it as the active focus and mention it in the Focus stack section, append the new focus file to the Children list in `focus.index.md`, and append a one-line entry to `status.index.md`'s Journal trail section when session 01 closes in Step 7. If there is no clear first goal, leave status as headless and skip this action.
3. **Anything else for session one** — optional context recorded in the first journal entry in Step 7.

Step 6 is an update-in-place step. No files are created; the skeleton already has the shape, Step 6 just fills in the project-specific content the skeleton left blank.

## Step 7 — Verify, install the session entry point, and record

Verify the Memory tree and the built Process against this checklist. Each line is a yes/no the driver either confirms or fixes before proceeding.

- `{lore_dir}/memory/memory.index.md` exists and opens with `# <project_name> — Memory` (project name substituted).
- Every folder under `{lore_dir}/memory/` contains its `[folder-name].index.md` — `memory.index.md`, `status/status.index.md`, `status/focus/focus.index.md`, `journal/journal.index.md`, `journal/live/live.index.md`, `journal/archive/archive.index.md`, `blueprint/blueprint.index.md`, `action-tree/action-tree.index.md`, `knowledge-tree/knowledge-tree.index.md`, `knowledge-tree/reconciled/reconciled.index.md`, `knowledge-tree/working/working.index.md`, `knowledge-tree/notepad/notepad.index.md`.
- `{lore_dir}/memory/blueprint/` was populated from the plugin seed in Step 5 and is not empty.
- `{lore_dir}/memory/knowledge-tree/knowledge-tree.index.md`'s `{project_overview}` placeholder has been replaced with the overview captured in Step 6.
- No `{project_name}` placeholder survives anywhere under `{lore_dir}/memory/` (`grep -r '{project_name}' {lore_dir}/memory/` returns nothing — the Step 4 sed pass actually substituted).
- `{lore_dir}/memory/status/status.index.md` matches the Step 6 outcome (headless if no initial focus was set; otherwise its Current state table and Focus stack name the active focus and its file exists under `{lore_dir}/memory/status/focus/`).
- The composed entry point at `{lore_dir}/process/ai_readme.md` exists. Link resolution is verified after the Step 7 `mv` install against the project-root copy, not the in-place composed copy — the root copy is the one sessions will load.
- `{lore_dir}/memory/` is a git repository (`git -C {lore_dir}/memory rev-parse --is-inside-work-tree` returns `true`).

Then install the session entry point by **moving** the composed full `ai_readme.md` from dist to the project root:

```bash
cd "$(git rev-parse --show-toplevel)"
LORE_DIR=$(printf '%s\n' .ai-lore-*/ | head -1)
LORE_DIR="${LORE_DIR%/}"

mv "${LORE_DIR}/process/ai_readme.md" ai_readme.md
```

`mv` rather than `cp` is deliberate. The rendered entry point has paths that resolve against the project root, not against its location inside `process/`; leaving a copy at `${LORE_DIR}/process/ai_readme.md` would create a second load target whose links are all broken relative to their location. Moving eliminates the stale copy — `process/` no longer contains `ai_readme.md` after bootstrap, and the project root is the only load target.

This is the closing move of bootstrap. From this point on the project has a root-level `ai_readme.md` and every subsequent session uses it; the bootstrap loader at `project-lifecycle/bootstrap/ai_readme-bootstrap.md` is never read again.

Write the first journal entry at `{lore_dir}/memory/journal/live/<date>_01.md` recording both parts of the bootstrap: project name, plugin, `core_version` pin, any focus opened, and the context captured in Step 6. There is no separate plugin version pin in v0.4 — plugins ship with core and are pinned via `core_version`.

Then append the new session file to `{lore_dir}/memory/journal/live/live.index.md`'s Children section. The skeleton ships the live index with a "(none yet — no sessions have been recorded)" placeholder; replace that placeholder with a one-line entry pointing at the journal file just written (e.g. `- [<date>_01.md](./<date>_01.md) — Bootstrap Part 2 (Migrator, Reflecting).`). Any session that writes a journal file owns updating its parent index — the session-close protocol's link-verification step assumes this has happened.

The project is now operational.
