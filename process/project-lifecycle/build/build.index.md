# Build process

> **References**
>
> | Group  | File                                                       |
> |--------|------------------------------------------------------------|
> | Parent | [../project-lifecycle.index.md](../project-lifecycle.index.md) |
> | Project structure | [../../project-structure.md](../../project-structure.md) |

Composes the Process dist from vendored Upstream. The build is version-selected (reads `core_version` from `workspace.yaml`), stages its output in `{lore_dir}/dist/process/core-<core_version>/`, and promotes it into single-version `{lore_dir}/process/` via a filesystem move as its last step.

Invoked by bootstrap Part 1 Step B (first install, through `setup-project.sh`) and by Migrator during version upgrades (Step 5 of `migration.md`, after the pin flip).

## Children

- [build-process.md](./build-process.md) — authoritative contract. Inputs, outputs, substitutions, excludes, promote-through-`dist/`. Migrator reads it during migrations to anchor patch-conflict resolution against the contract, independent of how the current script happens to satisfy it.
- [build-process.sh](./build-process.sh) — the implementation. Deterministic: same inputs → byte-identical outputs. No flags, no discretion.
