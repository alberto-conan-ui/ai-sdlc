# index.spec.md (Knowledge Tree Index)

**Type name:** knowledge-index
**File:** `index.spec.md`
**Location:** Every node in `knowledge-tree/` — root and each area folder
**Required:** Yes — one per knowledge tree node (the minimum spec)
**Created by:** Bootstrapper (root), Architect (area nodes)
**Maintained by:** All roles contribute; Curator audits

---

## Purpose

Orients the reader on what an area of the project covers, maps sub-areas so the AI knows whether to go deeper, and holds insights that apply broadly to this area. The root `knowledge-tree/index.spec.md` doubles as the project-level map — repo structure, cross-cutting patterns, and pointers into the tree.

---

## Format

```markdown
# <Area>

> Last updated: YYYY-MM-DD

## Overview

<What this area of the codebase does. 2-3 sentences — enough to orient
someone who hasn't worked here before.>

## Sub-areas

| Node | What it covers |
|---|---|
| [<child>/](./child/index.spec.md) | <one-line description> |
| [<specific>.spec.md](./specific.spec.md) | <one-line description> |

## Insights

<Insights that apply to this area broadly — not specific enough
for a sub-area file, but important for anyone working here.>
```

---

## Notes

- The root index additionally includes **What This Is**, **Tech Stack**, **Repo Structure**, **Key Files**, alongside Sub-areas and Insights. See [templates.md](../templates.md) for the inception and full root templates.
- `index.spec.md` is always the minimum — a knowledge tree node can't exist without one.
- See [knowledge-tree.md](../knowledge-tree.md) for growth patterns, splitting guidance, and what belongs at each level.
