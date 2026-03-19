# Journaling — The Recording System

> **References**
>
> | Group | File |
> |---|---|
> | Memory model | [memory.md](./memory.md) |
> | Principles | [principles.md](./principles.md) |
> | Workflow | [workflow.md](./workflow.md) |
> | Stances | [roles.md](./roles.md) |

AI-SDLC maintains a persistent record of what happened, what was learned, and what was decided. This document defines the recording system: what gets written, where it goes, and who writes it.

---

## The Journal Folder

Every session produces a journal folder in `journal/live/`. The folder is named by date and session number: `YYYY-MM-DD_NN/` (e.g., `2026-03-19_02/`). Each folder contains three minimum files:

**`YYYY-MM-DD_NN.index.md`** — the session overview. Uses the References/Siblings/Children navigation grammar (see [memory.md](./memory.md#the-index--navigation-primitive)). References link to the active action and previous session. An Entries table lists the session's entry files. A Handover table links to the handover file.

**One or more entry files** — each covering a distinct piece of work done in the session. One entry is the default. Additional entries when the session's work naturally breaks into separate chunks — the AI is trusted to group entries well. Entry files are named descriptively (e.g., `v021-design-expansion.md`, `auth-endpoint-audit.md`).

**`handover.md`** — a targeted message for the next session. See [The Handover](#the-handover) below.

Example folder:

```
journal/live/2026-03-19_02/
├── 2026-03-19_02.index.md       ← session overview
├── v021-design-expansion.md     ← entry: what happened
└── handover.md                  ← message for the next session
```

Journal references from AT/KT indexes point to specific entries or the session index — never to the folder itself. This gives "Relevant journal" precision: the AI loads exactly the context it needs.

---

## The Handover

The handover is the session continuity mechanism. It answers a different question than `status.md`: status.md says "where is the project"; the handover says "where was this work left."

**Audience:** The next session working on this action. The handover is action-scoped, not project-wide. It speaks to whoever picks up this thread of work next.

**Content:** What was being worked on, where it was left, what the next session needs to know to continue. Concretely: the active action, the mode at close, what was accomplished, what to do first, and any watch-out items.

**Relationship to status.md:** Status.md is updated every session (mutable). The handover is written once (append-forward). They're complementary — status.md gives the project-wide picture, the handover gives the action-specific thread.

**Read the handover before forming opinions about artifacts.** The handover tells the next session whether artifacts are approved plans or working drafts. In Planning mode (see [principles.md — Interaction Modes](./principles.md#interaction-modes)), the handover is the authority on what artifacts mean — not the artifacts themselves.

---

## Recording Destinations

There are two places to write session narrative. The action tree holds structure; narrative goes elsewhere.

### The journal (`journal/live/`)

The project's session record — the single place for all narrative recording. Every session writes a journal folder. Complete narrative — the AI extracts what matters when the journal is processed.

**What goes in:** everything that happened during the session. Decisions, observations, design reasoning, implementation progress, files touched, blockers encountered, process notes, cross-action patterns. If something is particularly insightful and may be worth migrating to the knowledge tree later, flag it clearly in the entry (e.g., "**Insight:** ...").

**Action context:** Journal entries naturally reference which action they're working on. The index's References section links to the active action. When you need to reconstruct the history of a specific action, search the journal by action name or follow the "Relevant journal" links from the action's index.

### The knowledge tree

Direct contributions — insights placed at the right node. The Architect writes to the KT when an insight is immediately clear and well-placed. No intermediary needed for design work.

**That's it.** All session narrative goes to the journal. The action tree holds specs, gatekeeps, and context — never narrative. This keeps the boundaries clean: the action tree is structure, the journal is narrative.

---

## Recording by Stance

Every stance reads the full orientation at session start and writes a journal folder at session close. The content differs by stance; the protocol is the same.

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

The Developer is occasional and constrained. Recording is lighter but follows the same protocol.

| Destination | What |
|---|---|
| `journal/live/` | Session narrative — what the prompt achieved, approach taken, any surprises |

The Developer does not write KT contributions. The Tech Lead handles insight routing for the execution flow.

### Auditor

The Auditor evaluates the process, not the product. Recording serves the diagnostic.

| Destination | What |
|---|---|
| `journal/live/` | Session narrative — findings, recommendations, migration actions |

---

## Session Close Protocol

Run at the close of every session. This is the same for all stances.

1. **Write the journal folder** in `journal/live/YYYY-MM-DD_NN/`:
   - Write one or more entry files covering the session's work.
   - Write the session index (`YYYY-MM-DD_NN.index.md`) with References to the active action and previous session, an Entries table, and a Handover table.
   - Write `handover.md` with the action-scoped message for the next session.

2. **Update `status.md`:** Current state summary, relevant journal references, next step, mode, project overview, history.

3. **Update knowledge tree** if insights from this session are immediately clear and well-placed.

4. **Verify all links** in new files point to `.md` files and resolve correctly.

### On action completion

- [ ] Journal entries from this action reviewed. Insights flagged as worth keeping migrated to the correct KT nodes?
- [ ] Journal completion note written if relevant to the broader project?
- [ ] Action subtree moved to `archive/`?
- [ ] `status.md` and `action-tree.index.md` updated — action popped from stack, status achieved?

---

## Weekly Log Rolling

Journal folders roll from `live/` to `archive/` on a weekly cadence. This keeps `live/` bounded — only recent sessions get loaded, which matters for context window efficiency.

**How it works:**

- At the start of each week, folders from the previous week (or earlier) that have been reviewed move to `journal/archive/`.
- The Human Lead triggers the roll — either manually or by asking the Architect to process the journal. Processing means: review `live/`, extract insights to the trees, then move processed folders to `archive/`.
- Folders that span the boundary (e.g., a Monday session referencing Friday's work) are fine to archive — the action tree and knowledge tree hold the durable information. The archive preserves the historical record if you need to go back.

**Why weekly:** Short enough that `live/` stays manageable (typically 5–15 session folders). Long enough that you're not constantly processing. The cadence is a guideline — if a busy week produces 20 sessions, process mid-week. If a quiet week produces 2, let them roll naturally.

**What every stance needs to know:** When you start a session, the journal folders in `live/` are the recent context. Older sessions are in `archive/` and can be loaded on demand, but `live/` is what gets read by default. If `live/` is growing unbounded, that's a signal the Human Lead needs to trigger processing.

---

## The Append-Forward Rule

All recording files follow the append-forward principle (see [principles.md](./principles.md)). Entries and handovers are never edited or deleted after they're written. The only files that genuinely mutate are `status.md` and `action-tree.index.md`.

---

## Recording Anti-Patterns

**The rubber stamp.** Review the AI's journal entries and knowledge contributions as they appear. Five minutes of engaged review is worth more than an hour of passive accumulation.

**Journaling without flagging insights.** You write journal entries during implementation but never flag what's insightful. The journal grows; the knowledge tree stays empty after action completion. When something is worth keeping, mark it.

**Project-wide handovers.** The handover is action-scoped — it speaks to the next session working on this action, not to the project at large. If you're writing a handover that summarises the entire project state, you're writing status.md. Keep the handover focused: what were you working on, where did you leave it, what does the next session need.

**Skipping journal processing.** Folders accumulate in `live/` but the human never triggers processing. The journal becomes write-only. Processing is a human responsibility — trigger it at least weekly.

**Unbounded live/.** The `live/` folder grows past 15–20 session folders. This wastes context window on every session start and makes processing harder. Roll to `archive/` weekly.
