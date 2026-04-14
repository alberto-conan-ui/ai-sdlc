# Tracker

A tracker tracks intention at a given depth. It is the shared primitive under the two tracking nodes that matter everywhere — [status](./status.md) and [focus](./focus.md) — and under action-tree nodes when a focus is large enough to decompose. Loading this file means any session knows what a tracker is, what contract every tracker honors, and how trackers chain from the project's entry point down to whatever is being worked on right now.

## Fields

Every tracker has four fields:

- **Stack** — ordered children, top is active. Push to interrupt, pop to resume.
- **Active child pointer** — which child is currently being worked on.
- **Journal trail** — one-line entries pointing to relevant journal sessions.
- **Gate** — the definition of done for this tracker.

The fields are the minimum, not the maximum. Every tracker carries these; each instance extends with whatever content its role requires. Status stays thin. Focus flexes. Action-tree nodes carry domain-specific content.

## The chain

The tracker tree *is* the chain. Start at `memory/status/status.index.md`, follow the active child pointer down to the active focus, follow its active child pointer into the action tree if one exists, keep walking until there is nothing below. Each node adds exactly one thing that the parent does not already say. No node repeats its parent.

The chain is as deep as the work requires:

**Simple focus — a bug fix:**

```
Status (mode, active focus, last journal)
  └─ Focus: "fix login timeout" (gate: it works)
```

**Medium focus — feature work:**

```
Status
  └─ Focus: "add export feature" (gate: users can export CSV)
       ├─ AT node: "design export format" (done)
       └─ AT node: "implement export endpoint" (active)
```

**Heavy focus — a release:**

```
Status
  └─ Focus: "v0.4 release" (gate points to KT goals)
       └─ KT index: goals, key changes, narrative
            ├─ design/
            ├─ feedback/
            └─ plan/
```

The contract at every level: each tracker contains only what it adds. Status orients in three seconds. Focus holds the gate. Action-tree nodes track decomposed intention. Knowledge lives in the knowledge tree, referenced from the trackers that need it. If information appears in the wrong node, it is a bug — not a style choice.

## Ancestry and context

Two terms name what lies above and below any node in the chain.

- **Ancestry** — the ordered path from `memory/status/status.index.md` down to the node. Above.
- **Context** — the node and its subtree. At and below.

A memory operation firing on a node is scoped to both halves. The context is the primary working material; the ancestry's references to the context move with it as the context changes. An operation that touches only the context and leaves stale references above it has not finished.

**Current context.** The session's current context is the subtree rooted at the deepest node it is actively working on. The session infers it by walking the chain at session open and keeping the tip current as work moves — the active AT node under the active focus when an action tree is in play, the active focus when it is not, status itself when headless. An operation invoked without a named target applies to the tip of the current context; if the operation needs a different node, the Human Lead names it explicitly.

## Gates

Every tracker has a **gate**: the criteria that define done. A gate is concrete and evaluable, committed to when the tracker is created. It is not a prose description of completion — it is the list of conditions the Human Lead will check.

Some action-tree nodes are **gated** — they carry explicit criteria the Human Lead evaluates. Others are **ungated** — their completion is covered by a parent's gate. **Branch gates** have two parts: all children pass their own gates, *and* the branch's own gate passes.

Gates are the most important part of any tracker. Without them, work drifts. A session must not self-approve a gate pass — only the Human Lead moves a tracker past Review. This is where human accountability lives at the tracker level.

## Lifecycle

```
created ─→ active ─→ completed
                 └─→ abandoned
```

- **Created.** The Human Lead defines the tracker and its gate. The file is written to its home.
- **Active.** The tracker is on the stack and being worked. Only the top of the stack is actively worked — others are paused.
- **Paused.** The tracker has been stopped temporarily. The reason lives in the journal.
- **Completed.** The Human Lead evaluates the gate. If it passes, the file moves to `archive/`.
- **Abandoned.** The Human Lead decides the tracker is no longer worth pursuing. The file moves to archive with a note on why.

The journal captures every transition. The tracker file records current state; the journal records history.

## Status vocabulary

A single vocabulary applies across all tracker types: `Pending`, `Active`, `Paused`, `Review`, `Done` (ungated trackers), `Achieved` (gated trackers). The session can move a tracker up to `Review`; only the Human Lead moves it past `Review` to `Done` or `Achieved`. This is the tracker-level expression of human accountability.

## Action-tree nodes

When a focus is large enough to need tracked stages spanning multiple sessions, the action tree provides the structure. Action-tree nodes inherit the four tracker fields and extend with domain-specific content. The action tree itself — its structural primitives (container, leaf), its named types, its growing and archival mechanics — lives in the [Action tree sub-pillar](../memory/action-tree.md). This file covers only the tracker primitive AT nodes inherit from.
