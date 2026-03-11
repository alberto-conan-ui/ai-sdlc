---
type: process
audience: [human, ai]
depends_on: [principles.md]
---

# The Memory Model

AI-SDLC gives your project a durable memory through two complementary trees and a journal that bridges them. This is the central mechanism — everything else in the methodology serves it. Without persistent memory, every AI session starts from zero. With it, session 10 benefits from every lesson learned in sessions 1 through 9.

This document is the single reference for how memory works. Every role participates in maintaining it. The [Curator](../roles/curator.md) audits it. The Human Lead owns it.

> **Depends on:** [principles.md](./principles.md)
> **Extended by:** [journaling.md](./journaling.md) (recording pipelines), [file-types/key-insights.md](./file-types/key-insights.md) (KEY_INSIGHTS lifecycle)
> **See also:** [action-tree.md](./action-tree.md), [knowledge-tree.md](./knowledge-tree.md)

---

## The Two Trees

The project memory holds two trees. They serve different purposes and follow different rules, but they feed each other continuously.

### The Action Tree — Short-Term Memory

The action tree (`action-tree/`) holds the work in progress. It is the project's short-term memory — what's happening *right now*. Each action node carries files that capture the live state of the work: `log.md` (session history), `KEY_INSIGHTS.md` (working scratchpad for insights), `context.md` (links to relevant knowledge), and `gatekeep.md` (completion criteria). The action tree is temporary by design — when an action completes, its insights migrate to the knowledge tree and the action subtree moves to `archive/`.

See [action-tree.md](./action-tree.md) for the full tree structure, node files, gatekeeping model, and the active stack.

### The Knowledge Tree — Long-Term Memory

The knowledge tree (`knowledge-tree/`) is a folder hierarchy organised by the boundaries where different knowledge applies — typically mirroring your codebase, but also accommodating cross-cutting concerns. Each node holds curated insights as knowledge specs (`.spec.md` files) — patterns to follow, pitfalls to avoid, architectural decisions that constrain future work.

Unlike the action tree, the knowledge tree is permanent and living. Insights get added, refined, moved to a different node, or retired when they're no longer relevant. The tree grows organically as work takes you into different areas of the codebase — you don't scaffold it upfront.

See [knowledge-tree.md](./knowledge-tree.md) for the full structural guide — how to organise nodes, growth patterns, monorepo layouts, and what belongs at each level.

---

## The Journal — Bridge and Audit Trail

The journal (`journal/`) captures cross-cutting annotations — project-level decisions, observations spanning multiple actions, process changes. It sits between the two trees and serves two purposes: as a **bridge** (capturing what transcends individual actions) and as an **audit trail** (letting the Curator verify the memory pipeline). Detailed session history lives in each action's `log.md`, not in the journal.

For the journal's format, entry types, triggers, and rules, see [file-types/journal-entry.md](./file-types/journal-entry.md).

---

## How Memory Flows

The two trees and the journal form a pipeline. Work produces raw material; the pipeline turns it into durable knowledge.

```
┌─────────────────────────────────────────────────────────┐
│                     ACTION TREE                         │
│                                                         │
│  Sessions produce:                                      │
│    • log.md entries (what happened)                     │
│    • KEY_INSIGHTS.md entries (what was learned)         │
│                                                         │
│  Cross-cutting observations go to:                      │
│    • journal/ entries (decisions, patterns, process)     │
│                                                         │
└──────────────────────┬──────────────────────────────────┘
                       │
                       │  On action completion:
                       │  KEY_INSIGHTS.md reviewed
                       │  Worth-keeping insights migrate
                       │
                       ▼
┌─────────────────────────────────────────────────────────┐
│                    KNOWLEDGE TREE                        │
│                                                         │
│  Receives curated insights at the right structural node │
│  Maintained by all roles, audited by the Curator        │
│  Loaded by future sessions for relevant areas           │
│                                                         │
└─────────────────────────────────────────────────────────┘
                       ▲
                       │
                       │  Curator audits using:
                       │  journal/ + action logs + KEY_INSIGHTS
                       │
┌──────────────────────┴──────────────────────────────────┐
│                      JOURNAL                            │
│                                                         │
│  The audit trail that lets the Curator verify:          │
│    • Were insights captured?                            │
│    • Are they at the right level?                       │
│    • Is anything missing or stale?                      │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

The flow is continuous, not ceremonial. It happens as part of normal work — during sessions (log entries, insights, journal entries), during the work (early migration of durable insights), on action completion (KEY_INSIGHTS review and migration), and periodically via Curator audits.

For the detailed flow and session recording checklists that ensure nothing is missed, see [journaling.md — Recording by Engagement Mode](./journaling.md#recording-by-engagement-mode) and [journaling.md — Session Recording Checklists](./journaling.md#session-recording-checklists).

---

## The KEY_INSIGHTS.md Lifecycle

KEY_INSIGHTS.md is the scratchpad that bridges the gap between "something was learned" and "the knowledge tree reflects it." Understanding its lifecycle prevents insights from being lost or accumulating as noise.

The full lifecycle — when to write, format, migration triggers, placement rules, and when to discard — is defined in [file-types/key-insights.md](./file-types/key-insights.md).

---

## Every Role's Recording Responsibilities

Memory maintenance is not a separate activity — it's woven into every role's normal work. The specifics differ by stance, but the core responsibilities are shared. Every role also reads the relevant memory on session start: `knowledge-tree/index.spec.md` for orientation, plus the knowledge tree nodes that apply to the current action.

For the full responsibility matrix (who writes which file), the Developer exception, the Curator's audit role, and the session recording checklist, see [journaling.md — Who Writes What](./journaling.md#who-writes-what) and [journaling.md — Session Recording Checklists](./journaling.md#session-recording-checklists).

See [curator.md](../roles/curator.md) for the full Curator audit process.

