---
type: process
audience: [human, ai]
depends_on: [memory.md, workflow.md]
---

# Journaling — The Recording System

AI-SDLC maintains a persistent record of what happened, what was learned, and what was decided. This document defines how the recording system works — the pipelines, the mode boundaries, and the session checklists. For the definition of each individual file type (purpose, format, ownership, rules), see the [File Type Catalogue](./file-types/).

The recording system operates differently depending on the project's **engagement mode** — Shaping or Working (see [workflow.md — Engagement Modes](./workflow.md#engagement-modes)). The mode determines which recording files are active, what the pipeline looks like, and what a complete session close requires. This is not a matter of emphasis — the modes draw hard boundaries about what recording is permitted.

> **Depends on:** [memory.md](./memory.md), [workflow.md](./workflow.md)
> **Extended by:** [file-types/](./file-types/) (individual file type definitions)
> **See also:** [anti-patterns.md](./anti-patterns.md) (recording anti-patterns)

---

## Recording by Engagement Mode

### Shaping Mode

In Shaping, the system is oriented around the knowledge tree, the action tree structure, and codebase understanding. The primary stances are Architect, Navigator, and Curator. Recording in Shaping serves design, curation, and decision-making.

**Active recording files:**

| File | What it captures | Character |
|---|---|---|
| [`journal/`](./file-types/journal-entry.md) | Decisions, observations, process changes | **Primary output** — Shaping produces the bulk of journal activity |
| [`log.md`](./file-types/action-log.md) | Design decisions, exploration notes | Session continuity for multi-session Shaping work on an action |
| Knowledge tree | Direct contributions, migrations, curation | **Active** — insights go directly to the knowledge tree, not through a scratchpad |

**Not produced in Shaping:** [session receipts](./file-types/session-receipt.md), [`KEY_INSIGHTS.md`](./file-types/key-insights.md). There is no need for the insights scratchpad because Shaping works on the knowledge tree directly. Receipts are an implementation artefact — there is no code execution in Shaping.

**The Shaping pipeline:**

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

### Working Mode

In Working, the system is oriented around the action tree's active stack. The primary stances are Tech Lead and Developer. Recording in Working serves execution tracking and short-term memory that will feed the knowledge tree later.

**Active recording files:**

| File | What it captures | Character |
|---|---|---|
| [`log.md`](./file-types/action-log.md) | Implementation progress, files touched | Session-by-session execution history |
| [`KEY_INSIGHTS.md`](./file-types/key-insights.md) | Implementation pitfalls, code-level patterns | Working scratchpad — migrates to knowledge tree on action completion |
| [`NN-desc.receipt.md`](./file-types/session-receipt.md) | What a Developer session produced | **Every prompt** — the Developer's sole recording output |
| [`journal/`](./file-types/journal-entry.md) | Cross-cutting observations | **Exception path only** — written only if something transcends the current action |

**Not produced in Working:** knowledge tree contributions. Insights are captured in `KEY_INSIGHTS.md` and deferred for migration on action completion (which happens in Shaping). If you find yourself wanting to curate the knowledge tree, that is a signal to switch back to Shaping.

**The Working pipeline:**

```
During sessions:
┌──────────────────────────────────────────────────────┐
│  Implementation happens                               │
│    → log.md gets a session entry                     │
│    → KEY_INSIGHTS.md gets new insights (if any)      │
│    → Developer produces receipt (if executing prompt) │
│    → journal/ gets entry (only if cross-cutting)      │
└──────────────────────────────────────────────────────┘
                       │
On action completion:  │
┌──────────────────────▼───────────────────────────────┐
│  Switch to Shaping — KEY_INSIGHTS.md reviewed         │
│    → Keep: migrate to knowledge tree at right node   │
│    → Discard: transient, no longer relevant           │
│    → Revise: right idea, needs sharpening             │
│  Action subtree → archive/                           │
└──────────────────────────────────────────────────────┘
```

---

## Who Writes What

Not every role participates equally. The recording responsibilities are deliberately asymmetric — and they map to the engagement modes through the stances that are active in each mode.

**Shaping stances** (Architect, Navigator, Curator):

| Recording target | Architect | Navigator | Curator |
|---|---|---|---|
| `log.md` | Yes | Yes | Yes |
| `journal/YYYY-WNN.md` | Yes | Yes | Yes |
| Knowledge tree | Yes | No | Yes (editorial) |

**Working stances** (Tech Lead, Developer):

| Recording target | Tech Lead | Developer |
|---|---|---|
| `log.md` | Yes | **No** |
| `KEY_INSIGHTS.md` | Yes | **No** |
| `journal/YYYY-WNN.md` | Yes (exception only) | **No** |
| `NN-desc.receipt.md` | No | **Yes** |

**The Developer exception:** The Developer is exempt from memory maintenance. Its [session receipt](./file-types/session-receipt.md) is its only recording output. The Developer loads only the current implementation prompt — no design context, no logs, no knowledge tree. This isolation prevents the Developer from second-guessing the architecture and keeps it focused on literal prompt execution.

**The Curator's audit role:** The Curator doesn't produce new work — it audits the recording pipeline. In dedicated Shaping sessions, the Curator reads the journal, action logs, and KEY_INSIGHTS files, then proposes editorial actions: promote, demote, retire, rewrite, or add insights in the knowledge tree. The journal is the Curator's primary audit input.

**The Human Lead reviews everything.** The AI writes the recording artifacts. The Human Lead verifies they captured what actually happened. This review is where the recording system gets its trustworthiness — without it, the artifacts accumulate volume without value.

---

## Session Recording Checklists

These checklists run at the close of every session. They are the atomic gate that ensures recording duties are met before moving on. The active role and the Human Lead share responsibility for completing them.

### Shaping sessions (Architect, Navigator, Curator)

- [ ] **Cross-cutting decisions journaled.** Were any decisions or observations made that affect more than the current action? If yes, are they in `journal/YYYY-WNN.md`?
- [ ] **Knowledge tree current.** Did this session produce insights? Are they placed directly in the appropriate knowledge tree nodes?
- [ ] **Log entry written.** If this is multi-session work on an action, does `log.md` have an entry for this session?
- [ ] **STATUS.md current.** Does STATUS.md reflect the actual project state after this session?

### Working sessions (Tech Lead)

- [ ] **Log entry written.** Does `log.md` for the active action have an entry for this session?
- [ ] **Insights captured.** Did anything emerge during this session that matters beyond it? If yes, is it in `KEY_INSIGHTS.md`?
- [ ] **Cross-cutting decisions journaled.** Were any cross-cutting observations made? If yes — and only then — write a journal entry.
- [ ] **STATUS.md current.** Does STATUS.md reflect the actual project state after this session?

### Developer sessions

- [ ] **Session receipt written.** Does a `NN-desc.receipt.md` file exist for the prompt that was executed?
- [ ] **State changes documented.** Does the receipt's State changes field capture everything the next prompt needs to know?

### On action completion (switch to Shaping)

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

### Logging without insight capture (Working mode)

You write log entries diligently during implementation but never surface insights to `KEY_INSIGHTS.md`. The log grows; the knowledge tree stays empty after action completion because there was nothing to migrate. The log is for history — what happened when. Insights are for learning — what to do differently next time. Both are needed in Working mode.

### Insight hoarding (Working mode)

KEY_INSIGHTS.md accumulates entries across sessions but nothing ever migrates to the knowledge tree on action completion. The scratchpad becomes a graveyard. Review on completion is not optional — it is where Working mode's short-term memory feeds Shaping mode's long-term memory.

### Journal as log

Using the journal for action-scoped events. If it's about what happened within one action, it belongs in that action's `log.md`. The journal is for what transcends individual actions. This is especially tempting in Working mode where journal entries should be rare — don't use the journal as a substitute for `log.md` just because it feels more visible.

### Skipping the knowledge tree in Shaping

Working in Shaping mode but parking insights in `KEY_INSIGHTS.md` instead of writing directly to the knowledge tree. The scratchpad exists for Working mode because knowledge tree curation is not permitted there. In Shaping, you have direct access — use it. Deferring to the scratchpad in Shaping defeats the purpose of the mode.

### Missing Source fields

Writing KEY_INSIGHTS entries without Source fields. Without traceability, the Curator can't verify where an insight came from, and the knowledge tree becomes unauditable. Every insight needs a source.
