# File Type Catalogue

Every file in the project memory follows the naming convention **`[name].[type].md`**, where the type suffix tells you what the file is. This catalogue is the complete reference for all valid types.

For the overall memory structure, see [memory.md](../memory.md). For the recording system, see [journaling.md](../journaling.md).

---

## Universal

| Suffix | File pattern | Required | Purpose |
|---|---|---|---|
| `index` | `[folder-name].index.md` | **Yes — every folder** | Authority file for the folder. Describes purpose and lists contents. |

The index file is mandatory in every folder across all three memory layers. In the KT, it orients the reader and maps sub-areas. In the AT, it describes the topic or serves as the phase spec. At the AT root, it's the structural overview (tree structure, dependencies, node inventory).

---

## Knowledge Tree

| Suffix | File pattern | Required | Purpose |
|---|---|---|---|
| `spec` | `[concern].spec.md` | No | Deep knowledge about a specific concern — patterns, pitfalls, architectural decisions. |

KT nodes start with just a `[name].index.md`. When a concern accumulates enough knowledge, it gets its own `[name].spec.md` alongside the index. The index maps these files; each spec holds curated, actionable insights at the right structural level.

**Format for specs:**

```markdown
# <Area or Topic>

> Last updated: YYYY-MM-DD

## <Insight title — imperative, actionable>

**Context:** <The specific situation or pattern.>
**Insight:** <What to do or avoid — prescriptive, not descriptive.>
**Source:** <journal entry or action reference for full context>
```

---

## Action Tree — Topic nodes

| Suffix | File pattern | Required | Purpose |
|---|---|---|---|
| `gatekeep` | `[name].gatekeep.md` | **Yes** | Completion criteria — what "done" means for this topic. |
| `context` | `[name].context.md` | No | What the action is about + pointers to relevant KT nodes. |

Topic folders use the naming pattern `N.topic.name/`. Only the index and gatekeep are required; everything else is created when useful.

All session narrative — progress, decisions, insights — goes to the journal (`journal/live/`). The action tree holds structure, not narrative.

**Gatekeep format:**

```markdown
# <Action name> — Gatekeep

<Completion criteria. What does "done" mean?>

<For branch topics: "All children pass their gatekeeps AND [branch-level criteria].">
```

---

## Action Tree — Phase nodes

Phase folders use the naming pattern `N.phase.name/`. The index file IS the phase spec — no separate spec file needed.

**Phase spec format (the index file):**

```markdown
# <Phase name>

> **References**
>
> | Group | File |
> |---|---|
> | Parent topic | [../name.index.md](../name.index.md) |

## Goal

<What this phase achieves. 1-3 sentences.>

## Steps

1. <Specific step with file paths and code references>
2. <Next step>
...

## Test cases

| Input | Expected | Notes |
|---|---|---|
| ... | ... | ... |

## Done when

- [ ] <Concrete, verifiable criterion>
- [ ] <Another criterion>
```

---

## Action Tree — Task nodes

Tasks are single files using the naming pattern `N.task.name.md`. No folder, no children, no gatekeep. The task file contains a brief description of what needs doing.

**Task format:**

```markdown
# <Task name>

<What needs doing. Brief — a few sentences to a few paragraphs.
Include any relevant file paths or references.>
```

Tasks are marked complete in `status.md` and archived like everything else.

---

## Journal

Journal entries are session files in `journal/live/`, named `YYYY-MM-DD_NN.md`. No type suffix — the naming convention is date-based, not typed. Entries roll to `journal/archive/` on a weekly cadence (see [journaling.md](../journaling.md)).

The journal is the **only place** for session narrative. All recording goes here — decisions, implementation progress, observations, insights. Flag particularly insightful observations with **Insight:** so they're easy to find during journal processing.

**Example journal entry:**

```markdown
# 2026-03-17 — Session 2

**Stance:** Tech Lead
**Action:** 1.topic.auth-redesign / 2.phase.new-token-model

## What happened

Implemented the token refresh logic in `src/services/auth.ts`. The existing
session store used synchronous writes which blocked the refresh flow — refactored
to async following the pattern in `src/services/cache.ts`.

Tests green. Had to add a mock for the token endpoint in `tests/fixtures/`.

## Decisions

- Kept backward compatibility with the old sync API by adding an adapter.
  The adapter can be removed once all consumers migrate (tracked in the phase spec).

## Next

Phase 2 is complete. Ready for Architect to review and write phase 3 spec.

**Insight:** When refactoring sync-to-async patterns in this codebase, always check
for implicit ordering dependencies — three callers assumed synchronous completion.
```

---

## Project-Level

| File | Required | Purpose |
|---|---|---|
| `workspace.yaml` | Yes | Path references and workspace configuration. Created during setup. |
| `status.md` | Yes | Live pointer — current state, active stack, what to do next. Lives in `action-tree/`. |

The AT root index (`action-tree.index.md`) serves as the structural overview — tree structure, dependencies, node inventory. `status.md` is the live pointer that every session reads first.
