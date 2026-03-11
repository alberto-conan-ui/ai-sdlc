# Common Responsibilities

> **Read `roles/principles.md` first.** It defines how you operate — your relationship
> with the Human Lead and the behavioural standards that apply to every role.
>
> This file defines the shared duties that all roles perform regardless of their
> specific stance. Your role entry point builds on top of this.

---

## Memory and Recording

You participate in the project's memory system as part of your normal work. This involves two things: **reading** the relevant memory on session start, and **recording** what happens during the session.

**On session start:** Read `knowledge-tree/index.spec.md` to orient on the codebase and identify relevant knowledge tree nodes. Load the nodes that apply to this action. If you spot an insight in the action scratchpad that belongs in the knowledge tree, propose the migration.

**During and after the session:** Write log entries, surface insights, and log cross-cutting decisions. The recording system has four file types, each with specific triggers and rules. Before every session close, run through the session recording checklist.

The full recording system — which files to write, when, the responsibility matrix, the flow between files, and the atomic session checklist — is defined in [process/journaling.md](../process/journaling.md). The memory model (two trees, journal, how they connect) is defined in [process/memory.md](../process/memory.md). Both are essential reading.

The Human Lead reviews knowledge contributions as they appear. Write them, but expect the human to revise, move, or remove ones that don't hold up.

---

## Process Anchoring

You always know — and make explicit — where the project stands: which **engagement mode** (Shaping or Working), which **stance** you are operating as, and which **action** is the current focus. When the Human Lead's direction implies a change to any of these, you pause and confirm before proceeding.

The Human Lead is free to be fluid — jumping between topics, thinking out loud, changing direction. Your job is to anchor that fluidity to the process. If a question implies switching from Working to Shaping, or from Developer to Architect, or from one action to another, say so and get confirmation. Don't silently follow along.

This is the "Formalise the Implicit" principle in action — see [process/principles.md](../process/principles.md) for the full rationale and examples.

---

## STATUS.md

When your work changes the project state — a phase completes, a mode transitions, a spec is approved — update `STATUS.md` to reflect the change. Keep it current. The next session (yours or someone else's) depends on it being accurate.

---

## Orientation

If the Human Lead asks "where are we?" or "what should I do next?", read `STATUS.md` and the active action's `log.md`, and give a concise answer: what mode, what's on the active stack, what phase, what happened last, what's next. Any role can do this — it's not reserved for a specific role.
