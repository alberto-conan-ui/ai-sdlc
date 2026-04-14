# Bootstrap — Part 1

> Mechanical walkthrough for Part 1 of bootstrap. Routed to from [`bootstrap.index.md`](./bootstrap.index.md). Part 1 vendors AI-Lore Upstream, writes the project manifest, and composes the Process dist. No methodology is loaded in Part 1; that is Part 2's job, started from `bootstrap.index.md` once these commands have completed cleanly.

Two commands, run from the folder you want to bootstrap, with `<project_name>` and `<plugin>` chosen ahead of time. `<project_name>` must be filesystem-safe (`^[a-zA-Z0-9_][a-zA-Z0-9_-]*$`) and must not collide with any enclosing ancestor that already has a `.ai-lore-<project_name>/` folder — see [`bootstrap.index.md`](./bootstrap.index.md#pick-a-project-name-first). The plugin must be one of the folders shipped under the cloned core's `plugins/` folder — e.g. `sdlc`, `spec`, `ttrpg`.

## Step A — Vendor Upstream

```bash
git clone --depth 1 https://github.com/alberto-conan-ui/ai-sdlc .ai-lore-<project_name>/upstream/core
```

This is the entire installation of AI-Lore: a shallow clone of the latest core into `.ai-lore-<project_name>/upstream/core/` as an unversioned staging path. Step B resolves the core version from the clone's changelog and renames `upstream/core/` to `upstream/core-<version>/`, pinning the clone to its version on disk. From that point on, every path is versioned. The Lore folder is uniquely named per project — `<project_name>` is chosen up front and becomes the directory suffix from Step A onward. Bootstrap always runs against the latest release; later upgrades go through [migration](../migration/migration.index.md).

## Step B — Set up the project

```bash
bash .ai-lore-<project_name>/upstream/core/process/project-lifecycle/bootstrap/setup-project.sh <project_name> <plugin>
```

The script is local — it runs from the upstream Step A just vendored, not from a curl-ed URL. It validates `<project_name>` against the filesystem-safe regex, walks ancestors to refuse colliding nested projects, validates that the requested plugin exists, resolves `core_version` from the highest-numbered entry in the cloned core's `process/changelog/` (the changelog is the source of truth for version), git-inits the project root if it is not already its own git repo, writes `.ai-lore-<project_name>/workspace.yaml` with `project_name` / `core_version` / `plugin`, writes the AI-Lore `.gitignore` block at the project root (preserving any existing `.gitignore` entries), and calls [`build-process.sh`](../build/build-process.sh) to stage and promote `.ai-lore-<project_name>/process/` as dist. Authoritative build semantics live in [`build-process.md`](../build/build-process.md).

The script is rerun-safe and exits non-zero with diagnostics on any failure.

## After Part 1

When `setup-project.sh` exits cleanly, Part 1 is done. The project has `.ai-lore-<project_name>/upstream/core-<version>/`, `.ai-lore-<project_name>/workspace.yaml`, and `.ai-lore-<project_name>/process/` (single-version, promoted from the build staging at `.ai-lore-<project_name>/dist/process/core-<version>/`). There is no Memory yet and no project-root `ai_readme.md` — both land in Part 2. Return to [`bootstrap.index.md`](./bootstrap.index.md) and follow the Part 2 instructions.
