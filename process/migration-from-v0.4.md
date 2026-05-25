# Migration — v0.4 → v0.5

The playbook the [`upgrade`](./verbs/upgrade.md) verb applies when moving a project from AI-Lore v0.4 to v0.5.

v0.5 changes the configuration and operation layer, not the Memory model in shape. The migration is mostly mechanical: add the file schema, reshape what the removed machinery left behind, point the project at the plain-text methodology.

## Before starting

`upgrade` should run on a clean working tree. Take a [`save-point`](./verbs/save-point.md) — or a manual git commit of both the lore repo and the Payload repo — first. The migration deletes directories; the commit is the return point.

## Steps

### 1. Remove the build machinery, re-populate the methodology

The v0.4 build system is gone in v0.5. Delete these directories from `.ai-lore-<project>/`:

- `upstream/` — the pinned source checkouts
- `dist/` — build scratch
- `process/` — the built, substituted copy of the methodology (it will be replaced with the v0.5 plain-text copy in a moment)

v0.5 has no build, no substitution, no templates. But the methodology *is* still copied into the project — just as plain text. After deleting v0.4's `process/`, place v0.5's methodology:

- Write a two-line shim at `ai_readme.md` (project root) — the AI-agnostic handshake. Content: *"This project uses AI-Lore. Read `.ai-lore-<project_name>/process/ai_readme.md` and follow its instructions."*
- Copy v0.5's pillars and verbs verbatim into a fresh `.ai-lore-<project>/process/`.

This is the same placement [`init`](./verbs/init.md) does at project creation. Nothing under `memory/` is touched by this step.

### 2. Update the manifest

In `workspace.yaml`:

- Remove the `plugin` field.
- Set `core_version` to `"0.5"`.

`project_name` is unchanged.

### 3. Add the file schema

Every file under `memory/` gains YAML frontmatter — `type`, `title`, `updated`, `references` — plus its per-type fields. Walk the Memory tree and apply the schema from [`memory.md`](./memory.md). Each file's `references` frontmatter is the v0.4 reference-header table restated as data; the body structure is unchanged. All schema writes go through [`write-lore`](./verbs/write-lore.md).

### 4. Replace mode with posture and dials

v0.5 records the session's working register — its posture and its dials — in `status/status.index.md`.

- Replace the `mode` field with `posture`, value `plan`/`reshape`/`execute`. The default at migration time is `execute`. The posture verbs ([`plan`](./verbs/plan.md), [`reshape`](./verbs/reshape.md), [`execute`](./verbs/execute.md)) write this field; each posture is a real constraint (`plan` and `reshape` make the Payload read-only).
- Add a `dials` field. If the v0.4 project had a stance, drop the stance name and seed `dials` from the most recent journal entry's stance dials, or leave it for the Human Lead to set on first [`redial`](./verbs/redial.md).

Existing journal files keep their `Stance`/`Mode` headers (journals are append-forward); new journal files use the v0.5 header (`dials` and `posture` in place of stance and mode).

### 5. Add focus_type to existing focuses

Every focus file gains `focus_type` in its frontmatter. v0.5 distinguishes two shapes:

- `build` — concrete delivery against an evaluable gate.
- `goal` — directional work judged by the Human Lead.

Most v0.4 focuses are `build`. Set `focus_type: build` on each existing focus unless its gate is a prose vision rather than a checklist — in which case it is a `goal`.

### 6. Reshape the blueprint

v0.5's blueprint has three branches: `contracts/`, `processes/`, `mirror/`. The v0.4 blueprint was a single flat surface — its existing content moves into `contracts/`. Create the three child folders, each with its index; move existing blueprint content into `contracts/` unchanged. `processes/` and `mirror/` start empty.

### 7. Add the save-points ledger

Create `memory/save-points/` with its index. It starts empty — emptiness is a valid state. Note that in v0.5, `save-point` is a hard git-commit contract — see [`save-point.md`](./verbs/save-point.md).

### 8. Optionally, install into an engine

v0.5 runs as plain text with no further setup. If you want the verbs wired natively, run the [`install`](./verbs/install.md) verb for your engine (`install-claude`, and so on). This is optional — the plain-text path is the methodology in full.

### 9. Verify

Run [`orient`](./verbs/orient.md) in a fresh session. It should walk the focus chain cleanly, read the schema'd files without error, read the dials, posture, and focus type, detect that the working tree is clean (the migration has committed), and state the current context. Once verified, take a `save-point` to mark the completed migration.

## What does not change

The Memory model — status, focus, journal, blueprint, action tree, knowledge tree — keeps its shape, its focus chain, and its vocabulary. A reader who knew v0.4 Memory will recognise v0.5 Memory. The save-points ledger and the blueprint sub-structure are the structural additions.
