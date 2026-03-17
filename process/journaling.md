---
type: process
audience: [human, ai]
depends_on: [memory.md, workflow.md]
---

# Journaling — The Recording System

> **References**
>
> | Group | File |
> |---|---|
> | Memory model | [memory.md](./memory.md) |
> | Workflow | [workflow.md](./workflow.md) |
> | File type catalogue | [file-types/](./file-types/) |
> | Anti-patterns | [anti-patterns.md](./anti-patterns.md) |

AI-SDLC maintains a persistent record of what happened, what was learned, and what was decided. This document defines how the recording system works — the pipelines, the role-based responsibilities, and the session checklists. For the definition of each individual file type (purpose, format, ownership, rules), see the [File Type Catalogue](./file-types/).

---

## The Journal

The journal is the primary recording destination for all sessions. Every session produces a journal entry in `journal/live/`, named by date and session number (e.g., `2026-03-17_01.md`).

A journal entry captures what happened during the session: decisions made, observations, progress, blockers, insights. It is a complete, unstructured narrative — not tagged, not classified, not pre-routed. The tier-3 model extracts what matters when the journal is processed; the author's job is completeness, not taxonomy.

**What goes in the journal:** everything that happened in the session. Decisions, observations, design reasoning, implementation notes, process observations, blockers encountered, insights discovered.

**What does NOT go in the journal:** action-scoped implementation detail that only matters for the next prompt in the same action. That stays in the action's own `log.md` (if multi-session work requires continuity between sessions on the same action).

The distinction is simple: if it matters beyond this action, it's a journal entry. If it only matters for the next session on this same action, it's a log entry.

---

## Recording by Role

Each role has specific recording responsibilities. The boundaries are defined by the role itself — the Architect writes differently than the Developer.

### Design roles (Architect, Navigator, Auditor)

These roles produce the bulk of journal activity. Their work is oriented around design, curation, and decision-making.

**Recording targets:**

| Target | What it captures |
|---|---|
| `journal/live/` | Session narrative — decisions, observations, design reasoning |
| Knowledge tree | Direct contributions — insights placed at the right node |
| `log.md` | Action-scoped session continuity (if multi-session work on one action) |

Design roles write insights directly to the knowledge tree when they are immediately clear and well-placed. There is no scratchpad intermediary for design work.

### Implementation roles (Tech Lead, Developer)

These roles are oriented around the action tree's active stack. Their recording serves execution tracking.

**Recording targets:**

| Target | What it captures |
|---|---|
| `journal/live/` | Session narrative — what was implemented, issues encountered |
| `log.md` | Implementation progress, files touched (Tech Lead) |
| `KEY_INSIGHTS.md` | Implementation insights worth keeping beyond this action (Tech Lead) |

The Tech Lead surfaces implementation insights to `KEY_INSIGHTS.md` — a working scratchpad that gets reviewed on action completion. Worth-keeping insights migrate to the knowledge tree; the rest are discarded.

**The Developer exception:** The Developer's sole recording output is a session receipt. The Developer is exempt from journal entries, log entries, and insight capture. This isolation keeps the Developer focused on literal prompt execution.

---

## Who Writes What

**Design roles** (Architect, Navigator, Auditor):

| Target | Architect | Navigator | Auditor |
|---|---|---|---|
| `journal/live/` | Yes | Yes | Yes |
| Knowledge tree | Yes | No | No |
| `log.md` | Yes | Yes | Yes |

**Implementation roles** (Tech Lead, Developer):

| Target | Tech Lead | Developer |
|---|---|---|
| `journal/live/` | Yes | **No** |
| `log.md` | Yes | **No** |
| `KEY_INSIGHTS.md` | Yes | **No** |
| Session receipt | No | **Yes** |

**The Human Lead reviews everything.** The AI writes the recording artifacts. The Human Lead verifies they captured what actually happened.

---

## Session Checklists

These checklists run at the close of every session. They ensure recording duties are met before moving on.

### Design sessions (Architect / Navigator / Auditor)

- [ ] **Journal entry written.** Does `journal/live/` have an entry for this session?
- [ ] **Knowledge tree current.** Did this session produce insights that belong in the knowledge tree? If yes, are they placed at the appropriate nodes? (Architect only)
- [ ] **Log entry written.** If this is multi-session work on one action, does the action's `log.md` have an entry for this session?
- [ ] **STATUS.md current.** Does STATUS.md reflect the project state after this session?

### Tech Lead sessions

- [ ] **Journal entry written.** Does `journal/live/` have an entry for this session?
- [ ] **Log entry written.** Does the active action's `log.md` have an entry?
- [ ] **Insights captured.** Did anything emerge that matters beyond this action? If yes, is it in `KEY_INSIGHTS.md`?
- [ ] **STATUS.md current.** Does STATUS.md reflect the project state after this session?

### Developer sessions

- [ ] **Session receipt written.** Does a receipt file exist for the prompt executed?
- [ ] **State changes documented.** Does the receipt capture everything the next prompt needs to know?

### On action completion

- [ ] **KEY_INSIGHTS.md reviewed.** Has every entry been evaluated: keep, discard, or revise?
- [ ] **Migrations done.** Have the "keep" insights been placed in the correct knowledge tree nodes?
- [ ] **Journal note written.** Has a completion note been added to `journal/live/` if relevant?
- [ ] **Action archived.** Has the action subtree moved to `action-tree/archive/`?
- [ ] **STATUS.md updated.** Is the action marked as achieved and popped from the stack?

---

## The Append-Forward Rule

All recording files follow the append-forward principle (see [principles.md — Append-Forward](./principles.md#append-forward)). Entries are never edited or deleted after they're written. The only file that genuinely mutates is `STATUS.md`.

---

## Recording Anti-Patterns

### The rubber stamp

See [anti-patterns.md — The rubber stamp](./anti-patterns.md#the-rubber-stamp). In the recording context: review the AI's journal entries and knowledge contributions as they appear. Five minutes of engaged review is worth more than an hour of passive accumulation.

### Logging without insight capture

You write log entries diligently during implementation but never surface insights to `KEY_INSIGHTS.md`. The log grows; the knowledge tree stays empty after action completion because there was nothing to migrate. The log is for history — what happened when. Insights are for learning — what to do differently next time. Both are needed.

### Insight hoarding

KEY_INSIGHTS.md accumulates entries across sessions but nothing ever migrates to the knowledge tree on action completion. The scratchpad becomes a graveyard. Review on completion is not optional — it is where short-term memory feeds long-term memory.

### Journal as log

Using the journal for action-scoped implementation detail. If it only matters for the next session on this same action, it belongs in that action's `log.md`. The journal is for what matters beyond a single action.

### Skipping journal processing

Journal entries accumulate in `live/` but the human never triggers processing. The journal becomes a write-only archive. Processing is a human responsibility — the Architect can't extract insights from entries nobody asks it to review.
