# Project lifecycle

> **References**
>
> | Group            | File                                             |
> |------------------|--------------------------------------------------|
> | Project structure | [../project-structure.md](../project-structure.md) |
> | Memory            | [../memory/memory.index.md](../memory/memory.index.md) |
> | Stances (Migrator) | [../stances/migrator.md](../stances/migrator.md) |

The lifecycle docs and scripts that take a project from nothing to operational and keep it aligned with upstream as it evolves. Three concerns, three subfolders — bootstrap, build, migration.

## Children

- [bootstrap/bootstrap.index.md](./bootstrap/bootstrap.index.md) — bring a project from nothing to operational. Two parts: a shell-driven Part 1 (vendor upstream, compose Process) and a Migrator-driven Part 2 (initialize Memory, install session entry point).
- [build/build.index.md](./build/build.index.md) — compose the Process dist from vendored Upstream. Authoritative contract and the script that implements it. Shared by bootstrap and migration.
- [migration/migration.index.md](./migration/migration.index.md) — upgrade a project from one pinned `core_version` to another. Migrator-driven, two parts: a mechanical Part 1 (pull new Upstream, flip pin, rebuild) and an interactive Part 2 (playbook-driven Memory reshape).
