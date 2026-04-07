---
type: process
audience: [human, ai]
depends_on: [../principles.md, ../memory.md, ../roles.md]
---

# Core Changelog

This folder tracks the evolution of the AI-Lore core. Each version has its own file documenting what changed, why it changed, and the specific migration steps for existing projects. The Auditor uses this folder as the primary reference when performing version migrations.

> **References**
>
> | Group | File |
> |---|---|
> | Process foundation | [principles.md](../principles.md), [memory.md](../memory.md), [roles.md](../roles.md) |
> | Used by | [roles/auditor.md](../../roles/auditor.md) (migration reference) |

---

## Version Entry Format

Each version file follows this structure:

- **Version number** — major.minor scheme. Minor bumps (0.1 -> 0.2) may require migration. Major bumps (0.x -> 1.0) indicate the process is considered stable.
- **Date** — when the version was declared.
- **Summary** — one paragraph: what changed and why.
- **Changes** — specific changes grouped by area (memory model, roles, conventions, etc.).
- **Migration steps** — what existing projects need to do to adopt this version. Written as concrete actions the Auditor can execute. If no migration is needed, state that explicitly.

---

## Versions

| Version             | Status              | Date           | Summary                                                                                                                    |
| ------------------- | ------------------- | -------------- | -------------------------------------------------------------------------------------------------------------------------- |
| [v0.1](./v0.1.md)   | Baseline            | Pre-2026-03-17 | Original process as shipped. Documented retroactively.                                                                     |
| [v0.2](./v0.2.md)   | Released            | 2026-03-18     | Redesign based on nine design principles from real-world usage.                                                            |
| [v0.21](./v0.21.md) | Released            | 2026-03-19     | Feedback-driven: interaction modes, session continuity, step node type, unified status.                                    |
| [v0.22](./v0.22.md) | Released            | 2026-03-21     | Migration hardening: hierarchical numbering, KT notepad, Reflecting mode, Developer removed.                               |
| [v0.25](./v0.25.md) | Released (internal) | 2026-03-31     | Process refinements: append-forward/reconciliation extracted, AT-is-intention, SDLC naming removed from core.              |
| [v0.27](./v0.27.md) | Released (internal) | 2026-04-06     | Core process docs: focus-based workflow, status entry point, KT three branches, optional AT, archetypes.                   |
| [v0.3](./v0.3.md)   | Released            | 2026-04-06     | Plugin architecture: slots/joins, mandatory plugins, independent versioning, `.ai-lore/` naming. Subsumes v0.25 and v0.27. |

**Current stable version:** v0.3
