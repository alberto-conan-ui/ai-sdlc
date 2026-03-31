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

## The Journal File

Every session produces a single journal file in `journal/live/`. The file is named by date and session number: `YYYY-MM-DD_NN.md` (e.g., `2026-03-19_02.md`). This file serves as both the session record and the handover for the next session.

**Header metadata table** — always present, always first:

```markdown
# Session NN — Title

| Field | Value |
|---|---|
| **Date** | YYYY-MM-DD |
| **Stance** | which stance was active |
| **Mode** | Planning / Executing / Reflecting |
| **Active action** | which action was the focus |
```

**Body** — the stance's judgment determines structure and depth. A heavy design session may need detailed decision logs. A routine execution session might just be "implemented X, tests pass, no surprises." The body captures *what happened*: decisions made, blockers encountered, process notes. Link to artifacts rather than restating their content — if a KT node was written, link to it; if an AT goal was created, link to it; if a spec was updated, reference it. The journal records that something happened and why, not the thing itself. If something is particularly insightful and may be worth migrating to the knowledge tree later, flag it clearly (e.g., "**Insight:** ...").

**Handover section** — always present, always last. A targeted message for the next session working on this action. See [The Handover](#the-handover) below.

Example file:

```markdown
# Session 02 — Auth endpoint audit

| Field | Value |
|---|---|
| **Date** | 2026-03-19 |
| **Stance** | Architect |
| **Mode** | Executing |
| **Active action** | Goal 2 — Auth Redesign |

## What Happened

[Session narrative — decisions, work done, observations]

## Handover

[What the next session needs to know]
```

Journal references from AT/KT indexes point to specific session files — not to folders. This gives "Relevant journal" precision: the AI loads exactly the context it needs.

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

The project's session record — the temporal narrative. Every session writes a journal file. The journal captures *what happened*: decisions made, blockers encountered, process notes. Link to artifacts (AT nodes, KT nodes, specs) rather than restating their content — the journal records that something happened and why, not the thing itself. If something is particularly insightful and may be worth migrating to the knowledge tree later, flag it clearly (e.g., "**Insight:** ...").

**Action context:** Journal entries naturally reference which action they're working on. The header metadata links to the active action. When you need to reconstruct the history of a specific action, search the journal by action name or follow the "Relevant journal" links from the action's index.

### The notepad (`knowledge-tree/notepad/`)

Action-scoped observations — things you notice during execution that don't belong in the temporal journal or in curated KT nodes yet. A bug spotted in passing, a pattern worth revisiting, a "this will matter later" note. The notepad captures *what you noticed* while doing other work, without forcing you to decide where the observation ultimately belongs.

The journal says "what happened in this session." The notepad says "what I noticed about this area of work." They're complementary: the journal is temporal (one file per session), the notepad is topical (one node per action). An observation can live in both if it serves both purposes — but the notepad is where action-scoped observations accumulate across sessions, making them findable by action rather than by date.

On action completion, durable findings in the notepad migrate to domain KT nodes. The notepad node archives with the action. See [knowledge-tree.md — The Notepad Branch](./knowledge-tree.md#the-notepad-branch) for the full lifecycle.

### The knowledge tree

Direct contributions — insights placed at the right node. The Architect writes to the KT when an insight is immediately clear and well-placed. No intermediary needed for design work.

**The boundaries.** All session narrative goes to the journal. Action-scoped observations go to the notepad. Curated, durable insights go to the knowledge tree. The action tree holds intention and gatekeeps — never narrative, observations, or design knowledge. All knowledge lives in the KT from day one, referenced from the AT.

---

## Session Close Protocol

Run at the close of every session. This is the same for all stances.

1. **Stance proposes status.** The active stance proposes the full status update: mode, active action, next step, relevant journal links. The Human Lead confirms or corrects. This leverages the stance's full session context rather than asking the human to reconstruct it.

2. **Write the journal file** in `journal/live/YYYY-MM-DD_NN.md`:
   - Header metadata table (date, stance, mode, active action)
   - Session body covering the work done
   - Handover section as the last part of the file, using the status the Human Lead confirmed in step 1

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

Journal files roll from `live/` to `archive/` on a weekly cadence. This keeps `live/` bounded — only recent sessions get loaded, which matters for context window efficiency.

**How it works:**

- At the start of each week, files from the previous week (or earlier) that have been reviewed move to `journal/archive/`.
- The Human Lead triggers the roll — either manually or by asking the Architect to process the journal. Processing means: review `live/`, extract insights to the trees, then move processed files to `archive/`.
- Files that span the boundary (e.g., a Monday session referencing Friday's work) are fine to archive — the action tree and knowledge tree hold the durable information. The archive preserves the historical record if you need to go back.

**Why weekly:** Short enough that `live/` stays manageable (typically 5–15 session files). Long enough that you're not constantly processing. The cadence is a guideline — if a busy week produces 20 sessions, process mid-week. If a quiet week produces 2, let them roll naturally.

**What every stance needs to know:** When you start a session, the journal files in `live/` are the recent context. Older sessions are in `archive/` and can be loaded on demand, but `live/` is what gets read by default. If `live/` is growing unbounded, that's a signal the Human Lead needs to trigger processing.

---

## The Append-Forward Rule

All journal files follow the append-forward principle unconditionally (see [principles.md](./principles.md)). Journal files are never edited or deleted after they're written — not even during reconciliation. The journal is the audit trail; it records transformations, it is never itself transformed. Old journal files move to `archive/` through normal weekly rolling, never through editing or deletion.

The AT and KT may be reshaped during a formal reconciliation (see [memory.md — Reconciliation](./memory.md#reconciliation)), but the journal documents that reshaping as new entries — preserving a complete, trustworthy history.

