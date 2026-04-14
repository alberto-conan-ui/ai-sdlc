# Build process — contract

The build composes `{lore_dir}/process/` as **dist** — the substituted, disposable output produced from Upstream and `workspace.yaml`. This file is the spec `build-process.sh` is verified against: the script is the implementation, this file is what the implementation promises. Migrator reads it during version migrations to anchor patch-conflict resolution against the contract, independent of how the current script happens to satisfy it.

## Source and dist

Upstream is **source**: pristine, byte-comparable against the git pin, never hand-edited. It lives at `{upstream_dir}` — `{lore_dir}/upstream/core-<core_version>/`.

Process is **dist**: the composed, substituted output. Rebuildable at any time by rerunning the build against unchanged Upstream. Hand-edits are invalid and get overwritten by the next build. It lives at `{lore_dir}/process/`, single-version, no suffix.

**Upstream is versioned; Process is not.** Upstream carries a `core-<core_version>` suffix so Migrator can read old and new pins side by side during a migration. Process is single-version — it always holds exactly the currently-active build — so sessions searching under `process/` never cross version boundaries. The `core_version` field in `workspace.yaml` selects which Upstream the build reads.

**Builds stage in `dist/` and promote by move.** The build composes its output at `{lore_dir}/dist/process/core-<core_version>/` and promotes it to `{lore_dir}/process/` as its final step via a filesystem move. The promotion is atomic — sessions never see a half-built `process/`. If a build fails mid-composition, the existing `process/` is untouched. `dist/` is the project-wide convention for script-produced intermediate output; each tool claims its own namespace under `dist/` (process builds live under `dist/process/`).

Substitution flows one way — source → dist. The build never writes back into Upstream.

## Inputs

- `{upstream_dir}/` — pinned core, with plugins under `{upstream_dir}/process/plugins/`.
- `{lore_dir}/workspace.yaml` — `project_name`, `core_version`, `plugin`.

The Lore folder itself is discovered by globbing `.ai-lore-*/` at the project root; exactly one match is expected. The discovered directory name must match `.ai-lore-${project_name}` from `workspace.yaml`, otherwise the build fails on self-verification. `core_version` is required — it determines which Upstream the build reads.

Nothing else is read.

## Output

- `{lore_dir}/process/` — the composed dist, shaped as declared in [`project-structure.md`](../../project-structure.md).

The build never writes outside `{lore_dir}/process/` and `{lore_dir}/dist/`. The project-root `ai_readme.md` is installed by [`bootstrap/step2.md`](../bootstrap/step2.md) Step 7, which **moves** the rendered file out of `process/` to the project root. The build does not leave the rendered entry point as a standalone file inside `process/` after the move.

## Contract

1. Resolve `{upstream_dir}` and the staged build directory from `workspace.yaml`:
   - `{upstream_dir}` = `{lore_dir}/upstream/core-<core_version>`
   - staged build directory = `{lore_dir}/dist/process/core-<core_version>`
2. Copy `{upstream_dir}/process/` into the staged build directory as the base layer, excluding source-only files and folders that must not appear in dist:
   - `base-stances/` — source material plugins compose stances from; sessions never load it at runtime.
   - `plugins/` — plugins ship inside `{upstream_dir}/process/plugins/` but are composed into the staged build by step 3, not copied as siblings of the core pillars. Excluding them here prevents the double-copy that would otherwise land plugin content as a stale tree.
   - `project-lifecycle/bootstrap/memory-skeleton/` — source material Part 2 Step 4 copies into Memory; Step 4 reads from Upstream directly, never from the build.
   - `project-lifecycle/bootstrap/focus.template.md` — source material Part 2 Step 6 copies when creating the initial focus file; Step 6 reads from Upstream directly, same pattern as memory-skeleton.
3. Overlay `{upstream_dir}/process/plugins/<plugin>/` on top of the staged build, excluding `blueprint/` and `changelog/`. Plugin files at the same path as core files win — except plugin files at `stances/auditor.md` or `stances/migrator.md`, which fail the build (those two stances are protected infrastructure and cannot be overridden).
4. Rename `ai-spine/ai_readme.template.md` to `ai_readme.md` in the staged build so the tree-wide substitution pass in step 5 touches it alongside every other file.
5. Run a tree-wide substitution pass across every `.md` file under the staged build directory. Three placeholders flow through the build:
   - `{project_name}` — the short identifier from `workspace.yaml`.
   - `{lore_dir}` — the Lore folder name, e.g. `.ai-lore-tmp`.
   - `{upstream_dir}` — the versioned Upstream path, e.g. `.ai-lore-tmp/upstream/core-0.4`.

   There is no `{process_dir}` placeholder. Documents that need to reference the active Process use the literal string `{lore_dir}/process/` (which the substitution pass resolves to the real path via the `{lore_dir}` sub).
6. The following files are **excluded** from the substitution sweep because they document the placeholders and folder-name conventions as literal strings and must not be mutated:
   - `project-lifecycle/build/build-process.md` (this file).
   - `project-lifecycle/bootstrap/bootstrap.index.md` (user-facing bootstrap prose describing naming rules).
   - `project-lifecycle/bootstrap/step2.md` (Part 2 walkthrough — its bash blocks contain a runtime `sed "s|{project_name}|..."` that targets the literal placeholder, and its verification checklist names placeholders literally).
   - `project-structure.md` (the foundation pillar that defines what `{lore_dir}` and `{upstream_dir}` mean).
   - `changelog/` (historical records describing past folder-name and placeholder shapes).
7. Promote the staged build: wipe `{lore_dir}/process/` and move the staged build directory into place at `{lore_dir}/process/`. This is the atomic cutover. After the move, `dist/process/core-<core_version>/` no longer exists — rollback is a rebuild from a different `upstream/core-<version>/`, not a copy of the previous staged build.

## Purity

Same inputs → byte-identical outputs. Idempotent on rerun. Verification mode runs the build twice against the same Upstream and byte-compares the outputs; any divergence fails the release contract.

## Deferred to v0.5

The current overlay model forces a plugin to physically duplicate any core file it wants to ship as-is — e.g. spec ships its own copy of `architect.md` from `base-stances/` because there is no way to declare "include this core file under this path." v0.5 should add a cherry-pick directive (a manifest entry the plugin declares, the build resolves at compose time) so plugins can name shared source files by reference instead of copying bytes. Until then, duplication is the explicit cost of the simple-overlay model.
