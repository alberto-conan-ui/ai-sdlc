# Core Changelog

> **References**
>
> | Group | File |
> |---|---|
> | Memory | [../memory.md](../memory.md) |
> | Migration | [../migration-from-v0.4.md](../migration-from-v0.4.md) |
> | Used by | [../verbs/upgrade.md](../verbs/upgrade.md) (version migration) |

This folder tracks the evolution of AI-Lore core. Each version is documented here — release notes for what changed and why. The changelog is the source of truth for `core_version`; the [`upgrade`](../verbs/upgrade.md) verb reads the relevant entries when migrating a project between versions.

## Version layout

Three shapes coexist, by when the version shipped:

- **Flat file (v0.3 and earlier).** `v<version>.md` at the changelog root, release notes and migration steps inline. Preserved as historical record.
- **Folder (v0.4).** `v0.4/` contains `v0.4.index.md` plus a peer `migration-from-v0.3.md` playbook.
- **Flat file with root migration (v0.5 onwards).** `v<version>.md` holds the release notes; the migration playbook lives at the methodology root as `migration-from-<predecessor>.md`, where the `upgrade` verb reads it.

## Version entry format

Each release follows this structure: version number (major.minor.patch, so sort-V orders correctly), date, a one-paragraph summary, changes grouped by area, and a pointer to the migration playbook.

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
| [v0.4](./v0.4/v0.4.index.md) | Released   | 2026-04-15     | Discovery rewrite: pillars, ai-spine, four modes, four-stance set, scripted bootstrap, plugin overlay, versioned Upstream + `dist/` staging. |
| [v0.5](./v0.5.md)   | Draft               | 2026-05-22     | Subtraction: stances → dials, modes → postures, Status split from Memory, focus tracking primitive, references, methodology placed by `init`, bindings via `install`. Still in review. |

**Current version:** v0.4 (latest release); v0.5 in draft.
