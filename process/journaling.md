# Journaling — The Recording System

AI-SDLC maintains a persistent record of what happened, what was learned, and what was decided. This document is the single reference for all recording activity. Every role should read it. If you need to know what to write, when to write it, and where it goes — the answer is here.

Four file types carry the project's recorded history. They serve different purposes, live in different places, and follow different rules — but they form a single pipeline that turns raw session activity into durable project knowledge.

---

## The Four Recording Files

| File | What it captures | Scope | Location |
|---|---|---|---|
| [`log.md`](#action-log) | What happened session by session | Per action | `action-tree/<action>/log.md` |
| [`KEY_INSIGHTS.md`](#key-insights) | What was learned (working scratchpad) | Per action | `action-tree/<action>/KEY_INSIGHTS.md` |
| [`journal/YYYY-WNN.md`](#journal-entries) | Cross-cutting decisions, observations, process changes | Project-wide | `journal/` |
| [`NN-desc.receipt.md`](#session-receipts) | What a Developer session actually produced | Per prompt | `action-tree/<action>/phases/N-name/` |

Each is documented below with its purpose, format, triggers, and rules. For the pipeline that connects them, see [How Recording Flows](#how-recording-flows). For the atomic checklist that ensures nothing gets missed, see [Session Recording Checklist](#session-recording-checklist).

---

## Action Log

**File:** `log.md` at the action node where work happens.
**Created by:** The role active during the session.
**Who writes:** All roles except Developer.
**Rule:** Append-only. Entries are never edited after the session ends.

The action log is the session-by-session record of what happened while working on an action. What was done, what was decided, what surprised you. It is the action's short-term memory — it tells the next session where the previous one left off.

Logs live at the nodes where work happens. The Human Lead and the active role look up the tree when broader context is needed.

### When to write

Write a log entry at the end of every session that touches this action. No exceptions, no minimum threshold — if you worked on the action, log what happened.

### Format

```markdown
## YYYY-MM-DD — <Role>

<One-line summary: what was accomplished.>

**Detail:** *(optional — include for complex sessions, skip for simple ones)*
- **Phase:** N — <name>
- **Files touched:** <paths>
- **Open threads:** <anything pending>
- **Next:** <what to pick up next session>
```

Keep entries concise. The log is a trail, not a report.

### What belongs here vs. elsewhere

The log captures what happened within this action's scope. If something transcends this action — a decision that affects the whole project, a pattern noticed across multiple actions — it goes in the [journal](#journal-entries), not here. If something was learned that might matter beyond this action, it goes in [KEY_INSIGHTS.md](#key-insights) alongside the log entry.

For the full format specification, see [file-types/action-log.md](./file-types/action-log.md).

---

## Key Insights

**File:** `KEY_INSIGHTS.md` at the action node.
**Created by:** Any role (except Developer) during active work.
**Who writes:** All roles except Developer.
**Rule:** Working scratchpad — temporary by design. Migrates to the knowledge tree on action completion.

KEY_INSIGHTS.md bridges the gap between "something was learned" and "the knowledge tree reflects it." It is the working scratchpad for insights that emerge during the work — patterns discovered, pitfalls encountered, decisions that might matter beyond this action.

### When to write

Write immediately when you encounter something that matters beyond the current session. Don't wait to see if it'll matter; write it and let review sort it out. The cost of writing a transient insight is low. The cost of losing a durable one is high.

### Format

```markdown
## <Insight title — imperative, actionable>

**Context:** <the specific situation or pattern>
**Insight:** <what to do or avoid — prescriptive, not descriptive>
**Source:** journal/YYYY-WNN.md, YYYY-MM-DD (or action log reference)
```

Insights must be prescriptive, not descriptive. Bad: "Refactoring was hard." Good: "Before any refactor that moves code between modules, write automated tests that assert current behaviour. Run them before and after. If they pass without test changes, the refactor preserved behaviour."

### The lifecycle

1. **Write immediately** when the insight surfaces during work.
2. **Migrate early** if the insight is clearly about a specific codebase area and is durable — not just relevant to this action. Propose placement in the knowledge tree and let the Human Lead confirm.
3. **Review on action completion** — everything still in KEY_INSIGHTS.md gets evaluated: keep (migrate to knowledge tree), discard (turned out to be transient), or revise (needs sharpening).
4. **Discard is fine** — the scratchpad is for working. The action's `log.md` preserves the historical context if you ever need to understand why something was tried.

### Where insights go

- Specific to this action's work → stays in `KEY_INSIGHTS.md` until completion review
- About a specific area of the codebase → knowledge tree node matching that area
- Cross-cutting, project-wide → `knowledge-tree/index.spec.md`

If you're unsure about placement, propose it and let the Human Lead confirm or redirect.

### The Source field

The **Source** field links the insight back to where it was learned — an action log entry or a journal entry. This is what makes the Curator's audit possible. Every insight in the knowledge tree must be traceable to its origin.

For the full format specification, see [file-types/key-insights.md](./file-types/key-insights.md).

---

## Journal Entries

**File:** `YYYY-WNN.md` (e.g., `2026-W10.md`) in the `journal/` folder.
**Created by:** Any role (except Developer) when cross-cutting annotations arise.
**Who writes:** All roles except Developer.
**Rule:** Append-only. Entries are never edited or deleted. Weekly rolling files.

The journal captures what transcends individual actions. A decision that affects the whole project, a pattern noticed across multiple actions, a process change — these don't belong in any single action's log. The journal is where they live.

The journal also serves as the Curator's primary audit input. When the Curator audits the memory, the journal is how they verify that insights were captured correctly, placed at the right level, and nothing important was lost.

### When to write

Write a journal entry when you make or encounter something that crosses action boundaries:

- A non-trivial project-level decision (e.g., choosing a new dependency, changing an architectural pattern)
- An observation that spans multiple actions (e.g., a recurring issue across different areas)
- A process change (e.g., adjusting how phases are structured, updating tooling)

If it's scoped to the current action, it belongs in the [action log](#action-log). If it transcends any single action, it belongs here.

### Entry types

- `[decision]` — a non-trivial project-level choice with context and reasoning
- `[observation]` — cross-cutting patterns, recurring issues, something worth tracking
- `[process]` — changes to how the team works, tooling updates, methodology adjustments

### Format

```markdown
# Journal — Week of YYYY-MM-DD

---

## YYYY-MM-DD — <Role> [decision]

<What was decided.>

**Context:** <What prompted this decision.>
**Reason:** <Why this option was chosen.>

---

## YYYY-MM-DD — <Role> [observation]

<What was noticed — cross-cutting pattern, recurring issue, something worth tracking.>

**Actions affected:** <which action nodes this touches>
**Implication:** <what this means for future work>

---

## YYYY-MM-DD — [process]

<What changed in how we work.>

**Reason:** <Why the change was made.>
```

### Naming

Files are named by ISO week: `YYYY-WNN.md` (e.g., `2026-W10.md`). One file per week, multiple entries per file.

For the full format specification, see [file-types/journal-entry.md](./file-types/journal-entry.md).

---

## Session Receipts

**File:** `NN-description.receipt.md` (e.g., `01-map-all-routes.receipt.md`) in the phase folder.
**Created by:** Developer at the end of each implementation session.
**Who writes:** Developer only.
**Rule:** One receipt per prompt executed. Mirrors its implementation prompt by name.

The session receipt is the Developer's sole contribution to the recording system. It is a formal record of what a Developer session actually produced, paired with its implementation prompt. The Tech Lead reads it before writing the next prompt, and the next prompt's preamble references it — keeping the chain of implementation grounded in reality rather than plans.

### When to write

At the end of every Developer session — no exceptions. If the Developer executed a prompt, it produces a receipt.

### Format

```markdown
# Session Receipt — NN-description

- **Role:** Developer
- **Prompt:** NN — <Short Description>
- **Status:** Complete / Partial / Blocked
- **Accomplished:** <what was done>
- **Files created/modified:** <paths>
- **State changes:** <structural changes the next prompt needs to know — new directories, changed exports, renamed files, altered type signatures>
- **Open issues:** <anything unexpected, flagged discrepancies, adaptations made>
```

**State changes** is the most important field. It captures the delta between the codebase the Tech Lead last saw and the codebase the next prompt will encounter. Without it, the Tech Lead is guessing — and guessing is how prompt assumptions go stale.

### What receipts don't do

The Developer is exempt from all other recording duties. No log entries, no KEY_INSIGHTS, no journal entries, no STATUS.md updates. The receipt is the Developer's full memory contribution. This isolation is by design — it keeps the Developer focused on literal execution.

For the full format specification, see [file-types/session-receipt.md](./file-types/session-receipt.md).

---

## Who Writes What

Not every role participates equally. The recording responsibilities are deliberately asymmetric.

| Recording file | Architect | Tech Lead | Developer | Navigator | Curator |
|---|---|---|---|---|---|
| `log.md` | Yes | Yes | **No** | Yes | Yes |
| `KEY_INSIGHTS.md` | Yes | Yes | **No** | Yes | Yes |
| `journal/YYYY-WNN.md` | Yes | Yes | **No** | Yes | Yes |
| `NN-desc.receipt.md` | No | No | **Yes** | No | No |

**The Developer exception:** The Developer is largely exempt from memory maintenance. Its session receipt is its only recording output. The Developer loads only the current implementation prompt — no design context, no logs, no knowledge tree. This isolation prevents the Developer from second-guessing the architecture and keeps it focused on literal prompt execution.

**The Curator's audit role:** The Curator doesn't produce new work — it audits the recording pipeline. In dedicated sessions, the Curator reads the journal, action logs, and KEY_INSIGHTS files, then proposes editorial actions: promote, demote, retire, rewrite, or add insights in the knowledge tree. The journal is the Curator's primary audit input.

**The Human Lead reviews everything.** The AI writes the recording artifacts. The Human Lead verifies they captured what actually happened. This review is where the recording system gets its trustworthiness — without it, the artifacts accumulate volume without value.

---

## How Recording Flows

The four recording files form a pipeline. Work produces raw material; the pipeline turns it into durable knowledge.

```
During sessions:
┌──────────────────────────────────────────────────────┐
│  Work happens                                        │
│    → log.md gets a session entry                     │
│    → KEY_INSIGHTS.md gets new insights (if any)      │
│    → journal/ gets cross-cutting entries (if any)     │
│    → Developer produces receipt (if executing prompt) │
└──────────────────────┬───────────────────────────────┘
                       │
During the work:       │
  Insights clearly     │
  durable and about    │
  a specific area?     │
  → Propose immediate  │
    migration to       │
    knowledge tree     │
                       │
On action completion:  │
┌──────────────────────▼───────────────────────────────┐
│  KEY_INSIGHTS.md reviewed                             │
│    → Keep: migrate to knowledge tree at right node   │
│    → Discard: transient, no longer relevant           │
│    → Revise: right idea, needs sharpening             │
│  Action subtree → archive/                           │
└──────────────────────┬───────────────────────────────┘
                       │
Periodically:          │
┌──────────────────────▼───────────────────────────────┐
│  Curator audits using journal as primary input        │
│    → Were insights captured?                         │
│    → Are they at the right knowledge tree level?      │
│    → Is anything missing or stale?                   │
└──────────────────────────────────────────────────────┘
```

The flow is continuous, not ceremonial. Recording happens as part of normal work — it is not extra work layered on top.

### Recording emphasis by engagement mode

The project's engagement mode (see [workflow.md — Engagement Modes](./workflow.md#engagement-modes)) shifts which recording files are most active:

| Recording file | Shaping mode | Working mode |
|---|---|---|
| `log.md` | Design decisions, exploration notes | Implementation progress, files touched |
| `KEY_INSIGHTS.md` | Architectural patterns, codebase learnings | Implementation pitfalls, code-level patterns |
| `journal/` | **Heavy** — decisions, observations, process | **Light** — only if cross-cutting |
| `receipt.md` | Not produced | **Every prompt** |
| Knowledge tree | **Active** — contributions, migrations, curation | **Deferred** — captured in KEY_INSIGHTS, migrated later |

Both modes use the same four file types and the same [session recording checklist](#session-recording-checklist). What changes is the emphasis and volume — shaping produces more journal entries and knowledge tree work; working produces more log entries and receipts.

---

## Session Recording Checklist

This checklist runs at the close of every session. It is the atomic gate that ensures recording duties are met before moving on. The active role and the Human Lead share responsibility for completing it.

### Every session (all roles except Developer)

- [ ] **Log entry written.** Does `log.md` for the active action have an entry for this session?
- [ ] **Insights captured.** Did anything emerge during this session that matters beyond it? If yes, is it in `KEY_INSIGHTS.md`?
- [ ] **Cross-cutting decisions journaled.** Were any decisions or observations made that affect more than the current action? If yes, are they in `journal/YYYY-WNN.md`?
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

All recording files follow the append-forward principle. Entries are never edited or deleted after they're written. When a plan changes, the new plan is a new artefact. When an insight is superseded, a new entry reflects the update. The old entries stay as the record of what was believed at the time.

This exists because rewriting history breaks the context chain. If a log entry gets silently edited, the journal entries that reference it no longer make sense. If a KEY_INSIGHTS entry gets modified rather than superseded, the Curator can't verify what was originally captured. By always moving forward, every past reference remains valid, and the journal tells a truthful story.

The only file that genuinely mutates is `STATUS.md`, and even that is just pointer updates: which action is active, which phase, which prompt. Everything else is append-only.

---

## Recording Anti-Patterns

### The rubber stamp

The AI writes a journal entry — you glance at it, looks fine, move on. The artefacts accumulate, all technically present, none actually reviewed. Three weeks later, the AI loads knowledge tree nodes that are too vague to be actionable. The process appears to be working, but the human review that gives the artefacts their value never happened.

The fix: read the AI's entries and ask — does this actually capture what happened? Is this specific enough that a fresh AI session could act on it? Five minutes of engaged review is worth more than an hour of passive accumulation.

### Logging without insight capture

You write log entries diligently but never surface insights. The log grows; the knowledge tree stays empty. The log is for history — what happened when. Insights are for learning — what to do differently next time. Both are needed.

### Insight hoarding

KEY_INSIGHTS.md accumulates entries across sessions but nothing ever migrates to the knowledge tree. The scratchpad becomes a graveyard. Migrate early when an insight is clearly durable. Review on completion for everything else.

### Journal as log

Using the journal for action-scoped events. If it's about what happened within one action, it belongs in that action's `log.md`. The journal is for what transcends individual actions.

### Missing Source fields

Writing KEY_INSIGHTS entries without Source fields. Without traceability, the Curator can't verify where an insight came from, and the knowledge tree becomes unauditable. Every insight needs a source.
