# Migrate a project to a new core version

> **References**
>
> | Group              | File                                                   |
> |--------------------|--------------------------------------------------------|
> | Parent             | [../project-lifecycle.index.md](../project-lifecycle.index.md) |
> | Project structure  | [../../project-structure.md](../../project-structure.md) |
> | Build              | [../build/build.index.md](../build/build.index.md)     |
> | Stances (Migrator) | [../../stances/migrator.md](../../stances/migrator.md) |

## Children

- [migrate-pull.sh](./migrate-pull.sh) — the mechanical fetch script for Part 1 Steps 1–3. Shallow-clones upstream, resolves the new version from the clone's changelog, compares against the current pin, stages the new Upstream next to the old.

---

Migration upgrades a running project from one pinned `core_version` to another. It runs in two parts, both driven by the **Migrator** stance in a dedicated session. **Part 1 — Pull and rebuild** is mechanical: fetch the new Upstream next to the old, show the human what is changing, flip the pin, rebuild `process/` from the new Upstream. **Part 2 — Memory reshape** is interactive: read the new version's migration playbook and walk the Memory through any structural changes the new pillars require. Both parts share the same discipline as bootstrap Part 2 — no silent edits, every write proposed first, stay with the alignment until it is done or explicitly blocked.

This document is the flow Migrator follows. Authoritative semantics for the build itself live in [`build-process.md`](../build/build-process.md). The vocabulary (Upstream, Process, Lore, `{upstream_dir}`) is defined in [`project-structure.md`](../../project-structure.md).

## When to run migration

Migration is the correct move when a newer `core_version` exists on upstream `main` and the Human Lead wants to adopt it. It is **not** the right move for:

- A fresh project — that's [bootstrap](../bootstrap/bootstrap.index.md).
- A broken build on the existing pin — that's a Migrator alignment run without a pin change.
- Experimental version trials — do those in a throwaway project, not the real one.

Do not run migration against a project with uncommitted work in `memory/`. Stop, commit, then start the migration session.

## Shape of the upgrade

Upstream is versioned; Process is single-version. Both live under the project's Lore folder:

```
{lore_dir}/
├── workspace.yaml                      core_version points at the active pin
├── upstream/
│   ├── core-<old_version>/             existing pin — kept until migration succeeds
│   └── core-<new_version>/             new pin — vendored by Part 1
├── dist/                               build staging — transient
└── process/                            single-version — rebuilt from the new pin at cutover
```

At every point before the cutover, the old pin is still active and sessions still work. The cutover is a single pin flip in `workspace.yaml` followed by a rebuild that promotes `dist/process/core-<new>/` to `process/` via a filesystem move. If the rebuild fails, the old Upstream is still on disk — roll back by flipping the pin in `workspace.yaml` back to `<old_version>` and rerunning `build-process.sh`.

## Part 1 — Pull and rebuild

Five mechanical steps. Migrator runs them, pausing for Human Lead confirmation at the steps marked **(pause)**.

### Step 1 — Check for a new release

Inspect the latest `core_version` on upstream `main`. The cheapest way is a shallow clone to a scratch path and reading the highest `v*.md` entry in its changelog — reuse of the same resolver `setup-project.sh` uses at bootstrap. Compare the result to `{lore_dir}/workspace.yaml`'s `core_version`:

- Same version: the project is already at the latest pin. Report and exit — nothing to do.
- Newer version available: proceed to Step 2.

### Step 2 — Confirm intent **(pause)**

Report the current pin, the new pin, and the new version's changelog entry to the Human Lead. The changelog is the authoritative description of what changes between the two pins — Migrator reads it in full before the confirmation ask. Do not proceed past this step without explicit Human Lead go-ahead. Abort here is harmless: nothing on disk has changed yet beyond the scratch clone, which can be deleted.

### Step 3 — Vendor the new Upstream

Move the scratch clone into place at `{lore_dir}/upstream/core-<new_version>/`. The old `{lore_dir}/upstream/core-<old_version>/` stays untouched — Migrator will read from both during Part 2. After this step, both pins coexist on disk; the project is still running on the old pin because `workspace.yaml` has not been updated yet.

The mechanical part of Step 3 is handled by `migrate-pull.sh`, which encapsulates Steps 1–3 into a single rerun-safe invocation. See its header comment for the full contract.

### Step 4 — Load the migration playbook **(pause)**

Read `{lore_dir}/upstream/core-<new_version>/process/changelog/<new_version>/migration-from-<old_version>.md` — the version-specific playbook the new core ships inside its release folder. From v0.4 onwards each release is its own folder under `changelog/`, containing `<version>.index.md` (release notes) plus any migration playbooks: `changelog/v0.4/v0.4.index.md` says what changed, `changelog/v0.4/migration-from-v0.3.md` says how to get there from v0.3, and any future `migration-from-<older>.md` playbooks live alongside them. If the playbook is missing for the specific predecessor version, halt and ask the Human Lead whether to proceed — a missing playbook is a ship-time gap in the new core and should be flagged, not worked around silently.

Present the playbook's scope to the Human Lead: what Memory is going to be reshaped, which files are going to move, what sections are going to be rewritten. Do not proceed past this step without explicit go-ahead. Abort here is still harmless: `workspace.yaml` has not been flipped, and `process/` still points at the old build.

### Step 5 — Flip the pin and rebuild

Update `{lore_dir}/workspace.yaml` to set `core_version: "<new_version>"`. Then run `{lore_dir}/upstream/core-<new_version>/process/project-lifecycle/build/build-process.sh`. The build reads the new pin, stages a composition at `dist/process/core-<new_version>/`, and promotes it to `process/` by filesystem move as its last step. From the moment the move completes, the project is semantically on the new version.

If the build fails mid-composition, `process/` is untouched — sessions keep running against the old composition. Roll back by flipping `workspace.yaml` back to the old pin and rerunning the build. If the build succeeds but the migration playbook reveals a problem the Human Lead wants to back out of, the same rollback works.

## Part 2 — Memory reshape

With `process/` now composed against the new version, Memory still reflects the old shape. Part 2 walks the Human Lead through the new version's migration playbook to bring Memory into line with the new pillars.

Memory reshape is interactive by design. The playbook names the changes; Migrator proposes each edit first, the Human Lead confirms, the edit lands. No silent writes, no batch operations that the Human Lead cannot follow step by step. The playbook is the spec, not a suggestion — deviations get flagged and discussed, not quietly skipped.

Every edit to Memory during Part 2 is append-forward where possible (see [`memory/tree-discipline.md`](../../memory/tree-discipline.md)) and journaled as it happens. If the playbook calls for Rewrite or Reshape verbs against specific nodes, Migrator invokes them against the nodes the playbook names, with the same propose-and-confirm discipline.

When the playbook's steps are complete, Migrator verifies the Memory tree against the new pillars' shape rules: every folder has its index, every file has a reference header (with the exemptions the new version declares), tracker fields on `status.index.md` and active focuses match the new tracker primitive, and every link in touched files resolves.

## Closing a migration

When Part 2 is complete, Migrator writes a migration session journal entry and hands off the same way bootstrap Part 2 does: suggest the Human Lead close the session cleanly and open a fresh one against the project-root `ai_readme.md` to resume normal work. The migration session is a one-shot state reshape; it must not become the project's first working session on the new pin.

Before closing, Migrator prunes the old Upstream folder if the Human Lead confirms — keep `upstream/core-<old>/` only if it is useful for rollback or reference. Default: keep through at least the next session, prune once the new pin is proven.

## Rollback

Rollback is always available up to the moment `workspace.yaml` is flipped in Step 5. After Step 5, rollback requires:

1. Flipping `workspace.yaml` back to `<old_version>`.
2. Rerunning `build-process.sh` to recompose `process/` against the old Upstream.
3. Reverting any Part 2 memory edits the Human Lead does not want to keep. Since every Part 2 edit was journaled, the rollback is read-the-journal-and-reverse, not guesswork.

Rollback after a partially-applied Part 2 is the expensive case — that is why Step 4's playbook review exists, and why Migrator refuses to proceed past Step 4 without explicit go-ahead.
