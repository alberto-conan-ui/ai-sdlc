---
type: process
audience: [human, ai]
depends_on: [memory.md, workflow.md]
---

# Journaling — The Recording System

AI-SDLC maintains a persistent record of what happened, what was learned, and what was decided. This document defines how the recording system works — the pipelines, the role-based responsibilities, and the session checklists. For the definition of each individual file type (purpose, format, ownership, rules), see the [File Type Catalogue](./file-types/).

Each role has specific recording responsibilities. The boundaries are defined by the role itself, not by a separate mode — the Architect writes to the knowledge tree directly, the Tech Lead writes to KEY_INSIGHTS.md, the Developer produces only a session receipt. The roles enforce what's appropriate.

> **Depends on:** [memory.md](./memory.md), [workflow.md](./workflow.md)
> **Extended by:** [file-types/](./file-types/) (individual file type definitions)
> **See also:** [anti-patterns.md](./anti-patterns.md) (recording anti-patterns)

---

## Recording by Role

### Design roles (Architect, Navigator, Curator)

These roles are oriented around the knowledge tree, action tree structure, and codebase understanding. Their recording serves design, curation, and decision-making.

**Recording files:**

| File | What it captures | Character |
|---|---|---|
| [`journal/`](./file-types/journal-entry.md) | Decisions, observations, process changes | Primary output — design work produces the bulk of journal activity |
| [`log.md`](./file-types/action-log.md) | Design decisions, exploration notes | Session continuity for multi-session design work on an action |
| Knowledge tree | Direct contributions, migrations, curation | Insights go directly to the knowledge tree, not through a scratchpad |

**Not produced by design roles:** [session receipts](./file-types/session-receipt.md), [`KEY_INSIGHTS.md`](./file-types/key-insights.md). There is no need for the insights scratchpad because these roles work on the knowledge tree directly. Receipts are an implementation artefact.

**The design pipeline:**

```
During sessions:
┌──────────────────────────────────────────────────────┐
│  Design / curation / exploration happens              │
│    → journal/ gets decisions and observations          │
│    → log.md gets a session entry (if multi-session)   │
│    → Knowledge tree gets direct contributions          │
└──────────────────────────────────────────────────────┘
                       │
Periodically:          │
┌──────────────────────▼───────────────────────────────┐
│  Curator audits using journal as primary input        │
│    → Are knowledge tree entries accurate?             │
│    → Is anything missing or stale?                   │
│    → Does the tree reflect the current codebase?      │
└──────────────────────────────────────────────────────┘
```

### Implementation roles (Tech Lead, Developer)

These roles are oriented around the action tree's active stack. Their recording serves execution tracking and short-term memory that will feed the knowledge tree later.

**Recording files:**

| File | What it captures | Character |
|---|---|---|
| [`log.md`](./file-types/action-log.md) | Implementation progress, files touched | Session-by-session execution history (Tech Lead only) |
| [`KEY_INSIGHTS.md`](./file-types/key-insights.md) | Implementation pitfalls, code-level patterns | Working scratchpad — migrates to knowledge tree on action completion (Tech Lead only) |
| [`NN-desc.receipt.md`](./file-types/session-receipt.md) | What a Developer session produced | Every prompt — the Developer's sole recording output |
| [`journal/`](./file-types/journal-entry.md) | Cross-cutting observations | Exception path only — written only if something transcends the current action (Tech Lead only) |

**Not produced by implementation roles:** knowledge tree contributions. Insights are captured in `KEY_INSIGHTS.md` and deferred for migration on action completion. If you find yourself wanting to curate the knowledge tree, switch to the Architect.

**The implementation pipeline:**

```
During sessions:
┌──────────────────────────────────────────────────────┐
│  Implementation happens                               │
│    → log.md gets a session entry (Tech Lead)         │
│    → KEY_INSIGHTS.md gets new insights (Tech Lead)   │
│    → Developer produces receipt (if executing prompt) │
│    → journal/ gets entry (only if cross-cutting)      │
└──────────────────────────────────────────────────────┘
                       │
On action completion:  │
┌──────────────────────▼───────────────────────────────┐
│  KEY_INSIGHTS.md reviewed                             │
│    → Keep: migrate to knowledge tree at right node   │
│    → Discard: transient, no longer relevant           │
│    → Revise: right idea, needs sharpening             │
│  Action subtree → archive/                           │
└──────────────────────────────────────────────────────┘
```

---

## Who Writes What

Not every role participates equally. The recording responsibilities are deliberately asymmetric.

**Design roles** (Architect, Navigator, Curator):

| Recording target | Architect | Navigator | Curator |
|---|---|---|---|
| `log.md` | Yes | Yes | Yes |
| `journal/YYYY-WNN.md` | Yes | Yes | Yes |
| Knowledge tree | Yes | No | Yes (editorial) |

**Implementation roles** (Tech Lead, Developer):

| Recording target | Tech Lead | Developer |
|---|---|---|
| `log.md` | Yes | **No** |
| `KEY_INSIGHTS.md` | Yes | **No** |
| `journal/YYYY-WNN.md` | Yes (exception only) | **No** |
| `NN-desc.receipt.md` | No | **Yes** |

**The Developer exception:** The Developer is exempt from memory maintenance. Its [session receipt](./file-types/session-receipt.md) is its only recording output. The Developer loads only the current implementation prompt — no design context, no logs, no knowledge tree. This isolation prevents the Developer from second-guessing the architecture and keeps it focused on literal prompt execution.

**The Curator's audit role:** The Curator doesn't produce new work — it audits the recording pipeline. In dedicated sessions, the Curator reads the journal, action logs, and KEY_INSIGHTS files, then proposes editorial actions: promote, demote, retire, rewrite, or add insights in the knowledge tree. The journal is the Curator's primary audit input.

**The Human Lead reviews everything.** The AI writes the recording artifacts. The Human Lead verifies they captured what actually happened. This review is where the recording system gets its trustworthiness — without it, the artifacts accumulate volume without value.

---

## Session Recording Checklists

These checklists run at the close of every session. They are the atomic gate that ensures recording duties are met before moving on. The active role and the Human Lead share responsibility for completing them.

### Architect / Navigator / Curator sessions

- [ ] **Cross-cutting decisions journaled.** Were any decisions or observations made that affect more than the current action? If yes, are they in `journal/YYYY-WNN.md`?
- [ ] **Knowledge tree current.** Did this session produce insights? Are they placed directly in the appropriate knowledge tree nodes?
- [ ] **Log entry written.** If this is multi-session work on an action, does `log.md` have an entry for this session?
- [ ] **STATUS.md current.** Does STATUS.md reflect the actual project state after this session?

### Tech Lead sessions

- [ ] **Log entry written.** Does `log.md` for the active action have an entry for this session?
- [ ] **Insights captured.** Did anything emerge during this session that matters beyond it? If yes, is it in `KEY_INSIGHTS.md`?
- [ ] **Cross-cutting decisions journaled.** Were any cross-cutting observations made? If yes — and only then — write a journal entry.
- [ ] **STATUS.md current.** Does STATUS.md reflect the actual project state after this session?

### Developer sessions

- [ ] **Session receipt written.** Does a `NN-desc.receipt.md` file exist for the prompt that was executed?
- [ ] **State changes documented.** Does the receipt's State changes field capture everything the next prompt needs to know?

### On action completion

- [ ] **KEY_INSIGHTS.md reviewed.** Has every entry been evaluated: keep, discard, or revise?
- [ ] **Migrations done.** Have the "keep" insights been placed in the correct knowledge tree nodes?
- [ ] **Journal completion note.** If relevant to the broader project, has the journal been updated?
- [ ] **Action archived.** Has the action subtree moved to `archive/`?
- [ ] **Curator session triggered.** Has a Curator audit been scheduled or run? This is the baseline cadence — every action completion warrants one.

---

## The Append-Forward Rule

All recording files follow the append-forward principle (see [principles.md — Append-Forward](./principles.md#append-forward)). Entries are never edited or deleted after they're written. The only file that genuinely mutates is `STATUS.md`.

---

## Recording Anti-Patterns

### The rubber stamp

See [anti-patterns.md — The rubber stamp](./anti-patterns.md#the-rubber-stamp). In the recording context specifically: review the AI's journal entries and knowledge contributions as they appear. Five minutes of engaged review is worth more than an hour of passive accumulation.

### Logging without insight capture

You write log entries diligently during implementation but never surface insights to `KEY_INSIGHTS.md`. The log grows; the knowledge tree stays empty after action completion because there was nothing to migrate. The log is for history — what happened when. Insights are for learning — what to do differently next time. Both are needed.

### Insight hoarding

KEY_INSIGHTS.md accumulates entries across sessions but nothing ever migrates to the knowledge tree on action completion. The scratchpad becomes a graveyard. Review on completion is not optional — it is where short-term memory feeds long-term memory.

### Journal as log

Using the journal for action-scoped events. If it's about what happened within one action, it belongs in that action's `log.md`. The journal is for what transcends individual actions. Don't use the journal as a substitute for `log.md` just because it feels more visible.

### Design roles parking insights in KEY_INSIGHTS

The Architect or Curator writing insights to `KEY_INSIGHTS.md` instead of the knowledge tree directly. The scratchpad exists for the Tech Lead during implementation because direct knowledge tree curation would be a distraction from execution. Design roles have direct access to the knowledge tree — use it.

### Missing Source fields

Writing KEY_INSIGHTS entries without Source fields. Without traceability, the Curator can't verify where an insight came from, and the knowledge tree becomes unauditable. Every insight needs a source.
