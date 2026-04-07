# spec Plugin — Session Configuration

> **References**
>
> | Group | File |
> |---|---|
> | Core template | [bootstrap/ai_readme.template.md](../../../bootstrap/ai_readme.template.md) |
> | spec stances | [roles.md](./roles.md) |

Read this file after the core process (steps 1–2 of the core ai_readme). This is step 3 — loading the plugin.

---

## Plugin

This project uses the **spec** plugin.
Plugin folder: `{methodology}/process/plugins/spec/`

## Plugin Loading Table

| # | File | Joins | What it adds |
|---|---|---|---|
| 6 | [roles.md](./roles.md) | roles.md — Substitution | Concrete stances: Editor (default), Strategist. Skip core archetypes. |
| 7 | [workflow.md](./workflow.md) | workflow.md — Addendum | Think → edit → commit cycle, Strategist session pattern |

---

## Stances

The human will tell you which stance to operate as, or you can infer from context:

| If the human says... | Load this stance |
|---|---|
| Default / "Let's work on..." / "Edit..." / "Design..." | Editor ([roles/editor.md](./roles/editor.md)) |
| "Switch to Strategist" / "Put on the Strategist hat" / "Evaluate readiness" | Strategist ([roles/strategist.md](./roles/strategist.md)) |
| "Audit the process / Review methodology" | Auditor ([roles/auditor.md](../../../roles/auditor.md)) — core stance |
| "Where are we? / Catch me up" | Either stance — orientation is a shared responsibility |

The default stance is **Editor**. Operate as Editor unless told otherwise.

---

## Quick Reference (plugin)

| Resource | Location |
|---|---|
| spec plugin docs | `{methodology}/process/plugins/spec/` |
| Editor stance | `{methodology}/process/plugins/spec/roles/editor.md` |
| Strategist stance | `{methodology}/process/plugins/spec/roles/strategist.md` |
| Auditor stance (core) | `{methodology}/roles/auditor.md` |
