# Core Changelog

> **References**
>
> | Group | File |
> |---|---|
> | Memory | [../memory/memory.index.md](../memory/memory.index.md) |
> | Stances | [../stances.md](../stances.md) |
> | Modes | [../modes.md](../modes.md) |
> | Used by | [../stances/migrator.md](../stances/migrator.md) (migration reference) |

This folder tracks the evolution of AI-Lore core. Each version is documented here — release notes for what changed and why, plus the migration playbook(s) for existing projects to adopt the version. The changelog is the source of truth for `core_version`: bootstrap reads the highest-numbered entry here and writes it into `workspace.yaml`. Migrator reads both the old and new entries during version upgrades.

## Version layout

Two shapes, chosen by when the version shipped:

- **Flat file (legacy, v0.3 and earlier).** `v<version>.md` at the changelog root, release notes inline. Migration steps live inside the same file. No folder. Preserved as historical record; not retrofitted to the new shape.
- **Folder (current, v0.4 onwards).** `v<version>/` contains `v<version>.index.md` (release notes, also serves as the folder index) plus any `migration-from-<predecessor>.md` playbooks. Future releases that need to support upgrades from multiple predecessors ship multiple playbooks in the same folder.

Both shapes coexist in this folder. The resolver in `setup-project.sh` and `migrate-pull.sh` unions flat files (`v[0-9]*.md`) with folders (`v[0-9]*/`) and takes the sort-V highest.

## Version entry format

Each release (flat file or folder index) follows this structure:

- **Version number** — major.minor.patch scheme (three segments minimum from v0.2.1 onwards) so sort-V orders correctly. Minor bumps may require migration. Major bumps indicate the process is considered stable.
- **Date** — when the version was declared.
- **Summary** — one paragraph: what changed and why.
- **Changes** — specific changes grouped by area (memory model, stances, conventions, etc.).
- **Migration** — v0.3 and earlier inline the migration steps; v0.4 and later ship them as a peer `migration-from-<predecessor>.md` file in the version folder.

## Versions

| Version             | Status              | Date           | Summary                                                                                                                    |
| ------------------- | ------------------- | -------------- | -------------------------------------------------------------------------------------------------------------------------- |
| [v0.1](./v0.1.md)   | Baseline            | Pre-2026-03-17 | Original process as shipped. Documented retroactively.                                                                     |
| [v0.2](./v0.2.md)   | Released            | 2026-03-18     | Redesign based on nine design principles from real-world usage.                                                            |
| [v0.2.1](./v0.2.1.md) | Released            | 2026-03-19     | Feedback-driven: interaction modes, session continuity, step node type, unified status.                                    |
| [v0.2.2](./v0.2.2.md) | Released            | 2026-03-21     | Migration hardening: hierarchical numbering, KT notepad, Reflecting mode, Developer removed.                               |
| [v0.2.5](./v0.2.5.md) | Released (internal) | 2026-03-31     | Process refinements: append-forward/reconciliation extracted, AT-is-intention, SDLC naming removed from core.              |
| [v0.2.7](./v0.2.7.md) | Released (internal) | 2026-04-06     | Core process docs: focus-based workflow, status entry point, KT three branches, optional AT, archetypes.                   |
| [v0.3](./v0.3.md)   | Released            | 2026-04-06     | Plugin architecture: slots/joins, mandatory plugins, independent versioning, `.ai-lore/` naming. Subsumes v0.2.5 and v0.2.7. |
| [v0.4](./v0.4/v0.4.index.md) | Released   | 2026-04-15     | Discovery rewrite: pillars, ai-spine, four modes, four-stance set, scripted bootstrap, plugin overlay, versioned Upstream + `dist/` staging. Ships with [`migration-from-v0.3.md`](./v0.4/migration-from-v0.3.md). |

**Current version:** v0.4.
