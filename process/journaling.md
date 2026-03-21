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

**Read the handover before forming opinions about artifacts.** The handover tells the next session whether artifacts are approved plans or working drafts. In Planning mode (see [principles.md — Interaction Modes](./principles.md#interaction-modes)), the handover is the authority on what artifacts mean — not the artifacts themselves. In Reflecting mode, the handover captures what triggered the reflection, what was discussed or reshaped, and whether the next session should continue reflecting or resume a forward-motion mode (Planning or Executing).

---

## Recording Destinations

There are three places to write during a session. The action tree holds structure; narrative and observations go elsewhere.

### The journal (`journal/live/`)

The project's session record — the temporal narrative. Every session writes a journal folder. The journal captures *what happened*: decisions, design reasoning, implementation progress, files touched, blockers encountered, process notes. If something is particularly insightful and may be worth migrating to the knowledge tree later, flag it clearly in the entry (e.g., "**Insight:** ...").

**Action context:** Journal entries naturally reference which action they're working on. The index's References section links to the active action. When you need to reconstruct the history of a specific action, search the journal by action name or follow the "Relevant journal" links from the action's index.

### The notepad (`knowledge-tree/notepad/`)

Action-scoped observations — things you notice during execution that don't belong in the temporal journal or in curated KT nodes yet. A bug spotted in passing, a pattern worth revisiting, a "this will matter later" note. The notepad captures *what you noticed* while doing other work, without forcing you to decide where the observation ultimately belongs.

The journal says "what happened in this session." The notepad says "what I noticed about this area of work." They're complementary: the journal is temporal (one folder per session), the notepad is topical (one node per action). An observation can live in both if it serves both purposes — but the notepad is where action-scoped observations accumulate across sessions, making them findable by action rather than by date.

On action completion, durable findings in the notepad migrate to domain KT nodes. The notepad node archives with the action. See [knowledge-tree.md — The Notepad Branch](./knowledge-tree.md#the-notepad-branch) for the full lifecycle.

### The knowledge tree

Direct contributions — insights placed at the right node. The Architect writes to the KT when an insight is immediately clear and well-placed. No intermediary needed for design work.

**The boundaries.** All session narrative goes to the journal. Action-scoped observations go to the notepad. Curated, durable insights go to the knowledge tree. The action tree holds specs, gatekeeps, and context — never narrative or observations.

---

## Recording by Stance

Every stance reads the full orientation at session start and writes a journal folder at session close. The content differs by stance; the protocol is the same.

### Architect

The Architect produces the bulk of project-level recording. Design sessions are where most decisions happen.

| Destination | What |
|---|---|
| `journal/live/` | Session narrative — decisions, design reasoning, action progress |
| `notepad/` | Observations noticed during design — patterns, concerns, questions to revisit |
| Knowledge tree | Direct insight contributions at the right node |

### Tech Lead

The Tech Lead is the primary executor. Recording serves execution tracking and insight capture.

| Destination | What |
|---|---|
| `journal/live/` | Session narrative — what was implemented, files touched, approach decisions, issues encountered. Flag insights worth keeping with **Insight:** |
| `notepad/` | Observations noticed during implementation — bugs spotted in passing, unexpected patterns, "this will matter later" notes |
| Knowledge tree | Direct contributions when an insight is immediately clear |

### Auditor

The Auditor evaluates the process, not the product. Recording serves the diagnostic.

| Destination | What |
|---|---|
| `journal/live/` | Session narrative — findings, recommendations, migration actions |
| `notepad/` | Observations about areas outside the audit scope — issues noticed but not the Auditor's remit to fix |

---

## Session Close Protocol

Run at the close of every session. This is the same for all stances.

1. **Ask for status.** Before writing anything, ask the Human Lead: "What's the status of the current action? Are we back in Planning? Is it ready for Review? Should the next session continue?" The handover captures the Human Lead's stated assessment, not the AI's inference. Closing a session is a logistics event, not a status declaration.

2. **Write the journal folder** in `journal/live/YYYY-MM-DD_NN/`:
   - Write one or more entry files covering the session's work.
   - Write the session index (`YYYY-MM-DD_NN.index.md`) with References to the active action and previous session, an Entries table, and a Handover table.
   - Write `handover.md` with the action-scoped message for the next session, using the status the Human Lead stated in step 1.

3. **Update `status.md`:** Current state summary, relevant journal references, next step, mode, project overview. Use the status the Human Lead confirmed.

4. **Update knowledge tree** if insights from this session are immediately clear and well-placed.

5. **Verify all links** in new files point to `.md` files and resolve correctly.

### On action completion

- [ ] Journal entries from this action reviewed. Insights flagged as worth keeping migrated to the correct KT nodes?
- [ ] Notepad node reviewed (if one exists). Durable findings migrated to domain KT nodes? Notepad node moved to `knowledge-tree/notepad/archive/`?
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
