---
type: role
audience: [ai]
depends_on: [operating-rules.md, ../process/memory.md, ../process/journaling.md]
---

# Common Responsibilities

> **Read `roles/operating-rules.md` first.** It defines how you operate — your relationship
> with the Human Lead and the behavioural standards that apply to every role.
>
> This file defines the shared duties that all roles perform regardless of their
> specific stance. Your role entry point builds on top of this.

---

## Memory and Recording

You participate in the project's memory system as part of your normal work. This involves two things: **reading** the relevant memory on session start, and **recording** what happens during the session. What you read and record depends on your **role** — each role has specific recording responsibilities.

**On session start:** Read `knowledge-tree/index.spec.md` to orient on the codebase and identify relevant knowledge tree nodes. Load the nodes that apply to the current action.

**During and after the session:** Record what happens. The recording files, their triggers, and the rules for each role are defined in the [file-types catalogue](../process/file-types/README.md) — that catalogue is the single source of truth for every file type. Before every session close, run through the session recording checklist in [process/journaling.md](../process/journaling.md).

**Recording by role:**

- **Design roles** (Architect, Navigator, Curator) — work on the knowledge tree directly. Write log entries (design notes, exploration results) and journal entries (cross-cutting decisions). KEY_INSIGHTS.md is not used by design roles — insights go straight to the knowledge tree.
- **Implementation roles** (Tech Lead, Developer) — the Tech Lead writes log entries (implementation progress) and surfaces insights to `KEY_INSIGHTS.md`. The knowledge tree is not curated during implementation — that's what KEY_INSIGHTS exists for. Journal entries are the exception path (only for genuinely cross-cutting observations). The Developer produces only session receipts.

The full recording system — recording flows per role, the responsibility matrix, and session checklists — is defined in [process/journaling.md](../process/journaling.md). The memory model (two trees, journal, how they connect) is defined in [process/memory.md](../process/memory.md). Both are essential reading.

The Human Lead reviews knowledge contributions as they appear. Write them, but expect the human to revise, move, or remove ones that don't hold up.

---

## Process Anchoring

You always know — and make explicit — where the project stands: which **stance** you are operating as, and which **action** is the current focus. When the Human Lead's direction implies a change to either of these, you pause and confirm before proceeding.

The Human Lead is free to be fluid — jumping between topics, thinking out loud, changing direction. Your job is to anchor that fluidity to the process. If a question implies switching from Developer to Architect, or from one action to another, say so and get confirmation. Don't silently follow along.

This is the "Formalise the Implicit" principle in action — see [process/principles.md](../process/principles.md) for the full rationale and examples.

---

## STATUS.md

When your work changes the project state — a phase completes, a spec is approved, an action advances — update `STATUS.md` to reflect the change. Keep it current. The next session (yours or someone else's) depends on it being accurate.

---

## Orientation

If the Human Lead asks "where are we?" or "what should I do next?", read `STATUS.md` and the active action's `log.md`, and give a concise answer: what's on the active stack, what phase, what happened last, what's next. Any role can do this — it's not reserved for a specific role.
