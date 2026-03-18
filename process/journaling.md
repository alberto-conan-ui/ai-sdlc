# Journaling — The Recording System

> **References**
>
> | Group | File |
> |---|---|
> | Memory model | [memory.md](./memory.md) |
> | Workflow | [workflow.md](./workflow.md) |
> | Stances | [roles.md](./roles.md) |

AI-SDLC maintains a persistent record of what happened, what was learned, and what was decided. This document defines the recording system: what gets written, where it goes, and who writes it.

---

## Recording Destinations

There are two places to write session narrative. The action tree holds structure; narrative goes elsewhere.

### The journal (`journal/live/`)

The project's session record — the single place for all narrative recording. Every session that produces decisions, observations, or insights writes a journal entry. Named by date and session number (e.g., `2026-03-17_01.md`). Complete, unstructured narrative — the AI extracts what matters when the journal is processed.

**What goes in:** everything that happened during the session. Decisions, observations, design reasoning, implementation progress, files touched, blockers encountered, process notes, cross-action patterns. If something is particularly insightful and may be worth migrating to the knowledge tree later, flag it clearly in the entry (e.g., "**Insight:** ...").

**Action context:** Journal entries naturally reference which action and phase they're working on. When you need to reconstruct the history of a specific action, search the journal by action name.

### The knowledge tree

Direct contributions — insights placed at the right node. The Architect writes to the KT when an insight is immediately clear and well-placed. No intermediary needed for design work.

**That's it.** All session narrative goes to the journal. The action tree holds specs, gatekeeps, and context — never narrative. This keeps the boundaries clean: the action tree is structure, the journal is narrative.

---

## Recording by Stance

### Architect

The Architect produces the bulk of project-level recording. Design sessions are where most decisions happen.

| Destination | What |
|---|---|
| `journal/live/` | Session narrative — decisions, observations, design reasoning, action progress |
| Knowledge tree | Direct insight contributions at the right node |

### Tech Lead

The Tech Lead is the primary executor. Recording serves execution tracking and insight capture.

| Destination | What |
|---|---|
| `journal/live/` | Session narrative — what was implemented, files touched, approach decisions, issues encountered. Flag insights worth keeping with **Insight:** |
| Knowledge tree | Direct contributions when an insight is immediately clear |

### Developer

The Developer is occasional and constrained. Recording is minimal.

| Destination | What |
|---|---|
| `journal/live/` | Brief entry noting what the prompt achieved and any surprises |

The Developer does not write KT contributions. The Tech Lead handles insight routing for the execution flow.

### Auditor

The Auditor evaluates the process, not the product. Recording serves the diagnostic.

| Destination | What |
|---|---|
| `journal/live/` | Session narrative — findings, recommendations, migration actions |

---

## Weekly Log Rolling

Journal entries roll from `live/` to `archive/` on a weekly cadence. This keeps `live/` bounded — only recent entries get loaded on session start, which matters for context window efficiency.

**How it works:**

- At the start of each week, entries from the previous week (or earlier) that have been reviewed move to `journal/archive/`.
- The Human Lead triggers the roll — either manually or by asking the Architect to process the journal. Processing means: review `live/`, extract insights to the trees, then move processed entries to `archive/`.
- Entries that span the boundary (e.g., a Monday entry referencing Friday's work) are fine to archive — the action tree and knowledge tree hold the durable information. The archive preserves the historical record if you need to go back.

**Why weekly:** Short enough that `live/` stays manageable (typically 5–15 entries). Long enough that you're not constantly processing. The cadence is a guideline — if a busy week produces 20 entries, process mid-week. If a quiet week produces 2, let them roll naturally.

**What every role needs to know:** When you start a session, the journal entries in `live/` are the recent context. Older entries are in `archive/` and can be loaded on demand, but `live/` is what gets read by default. If `live/` is growing unbounded, that's a signal the Human Lead needs to trigger processing.

---

## Session Checklists

Run at the close of every session. These ensure recording is complete before moving on.

### Architect sessions

- [ ] Journal entry written in `journal/live/` for this session?
- [ ] Knowledge tree current? Insights from this session placed at the right nodes?
- [ ] `status.md` current? Does it reflect the project state after this session?

### Tech Lead sessions

- [ ] Journal entry written in `journal/live/`? Insights flagged?
- [ ] `status.md` current?

### On action completion

- [ ] Journal entries from this action reviewed. Insights flagged as worth keeping migrated to the correct KT nodes?
- [ ] Journal completion note written if relevant to the broader project?
- [ ] Action subtree moved to `archive/`?
- [ ] `status.md` and `action-tree.index.md` updated — action popped from stack, status achieved?

---

## The Append-Forward Rule

All recording files follow the append-forward principle (see [principles.md](./principles.md)). Entries are never edited or deleted after they're written. The only files that genuinely mutate are `status.md` and `action-tree.index.md`.

---

## Recording Anti-Patterns

**The rubber stamp.** Review the AI's journal entries and knowledge contributions as they appear. Five minutes of engaged review is worth more than an hour of passive accumulation.

**Journaling without flagging insights.** You write journal entries during implementation but never flag what's insightful. The journal grows; the knowledge tree stays empty after action completion. When something is worth keeping, mark it.

**Skipping journal processing.** Entries accumulate in `live/` but the human never triggers processing. The journal becomes write-only. Processing is a human responsibility — trigger it at least weekly.

**Unbounded live/.** The `live/` folder grows past 15–20 entries. This wastes context window on every session start and makes processing harder. Roll to `archive/` weekly.
