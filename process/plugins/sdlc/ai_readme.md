# SDLC Plugin — Session Configuration

> **References**
>
> | Group | File |
> |---|---|
> | Core template | [bootstrap/ai_readme.template.md](../../../bootstrap/ai_readme.template.md) |
> | SDLC stances | [roles.md](./roles.md) |

Read this file after the core process (steps 1-2 of the core ai_readme). This is step 3 — loading the plugin.

---

## Plugin Loading Table

Load these files after core. Each has a **Joins** declaration explaining its relationship to the core file.

| # | File | Joins | What it adds |
|---|---|---|---|
| 6 | [roles.md](./roles.md) | roles.md — Substitution | Concrete stances: Architect, Tech Lead. Skip core archetypes. |
| 7 | [workflow.md](./workflow.md) | workflow.md — Addendum | Design -> implementation cycle, stance flow |
| 8 | [action-tree.md](./action-tree.md) | action-tree.md — Addendum | Five node types, containment rules, gate taxonomy |
| 9 | [conventions.md](./conventions.md) | conventions.md — Addendum | Node naming, phase spec format, recording by stance |

---

## Stances

The human will tell you which stance to operate as, or you can infer from context:

| If the human says... | Load this stance |
|---|---|
| "Let's design / plan / shape / architect" | Architect ([roles/architect.md](./roles/architect.md)) |
| "Implement / build / execute phase" | Tech Lead ([roles/tech-lead.md](./roles/tech-lead.md)) |
| "Audit the process / Review methodology" | Auditor ([roles/auditor.md](../../../roles/auditor.md)) — core stance |
| "Where are we? / Catch me up" | Any stance — orientation is a shared responsibility |

---

## Quick Reference (plugin)

| Resource | Location |
|---|---|
| SDLC plugin docs | `{methodology}/process/plugins/sdlc/` |
| Architect stance | `{methodology}/process/plugins/sdlc/roles/architect.md` |
| Tech Lead stance | `{methodology}/process/plugins/sdlc/roles/tech-lead.md` |
| Auditor stance (core) | `{methodology}/roles/auditor.md` |
