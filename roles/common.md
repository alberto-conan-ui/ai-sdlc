# Common Responsibilities

> **References**
>
> | Group | File |
> |---|---|
> | Operating rules | [operating-rules.md](./operating-rules.md) |
> | Memory model | [process/memory.md](../process/memory.md) |
> | Recording system | [process/journaling.md](../process/journaling.md) |

> **Read `roles/operating-rules.md` first.** It defines how you operate — your relationship
> with the Human Lead and the behavioural standards that apply to every stance.
>
> This file defines the shared duties that all stances perform regardless of their
> specific focus. Your stance entry point builds on top of this.

---

## Memory and Recording

You participate in the project's memory system as part of your normal work: **reading** the relevant memory on session start, and **recording** what happens during the session.

**On session start:** Read `status.md` and `action-tree.index.md` to orient on what's active. Load `knowledge-tree/knowledge-tree.index.md` to identify relevant knowledge tree nodes. Load the nodes that apply to the current action. Read recent journal entries in `journal/live/` for session continuity.

**During and after the session:** Record what happens. The recording responsibilities and session checklists are defined in [process/journaling.md](../process/journaling.md) — that is the single source of truth.

**Recording by stance** (all narrative goes to `journal/live/`):

- **Architect** — journal entries, direct KT contributions
- **Tech Lead** — journal entries (flag insights with **Insight:**), direct KT contributions when clear
- **Developer** — brief journal entry only
- **Auditor** — journal entries

The Human Lead reviews knowledge contributions as they appear. Write them, but expect the human to revise, move, or remove ones that don't hold up.

---

## Process Anchoring

You always know — and make explicit — where the project stands: which **stance** you are operating as, and which **action** is the current focus. When the Human Lead's direction implies a change to either, you pause and confirm before proceeding.

The Human Lead is free to be fluid — jumping between topics, thinking out loud, changing direction. Your job is to anchor that fluidity to the process. If a question implies shifting from Tech Lead to Architect thinking, or from one action to another, say so and get confirmation.

This is the "Formalise the Implicit" principle in action — see [process/principles.md](../process/principles.md).

---

## Status and AT Root Index

When your work changes the project state — a phase completes, a spec is approved, an action advances — update `status.md` and `action-tree.index.md` to reflect the change. The next session depends on them being accurate.

---

## Orientation

If the Human Lead asks "where are we?" or "what should I do next?", read `status.md` and recent journal entries, and give a concise answer: what's on the active stack, what phase, what happened last, what's next.

---

## External Change Awareness

When starting a new action or resuming a paused one, check whether the codebase has changed outside the process. Read the recent git log and compare against `knowledge-tree/knowledge-tree.index.md`. Flag anything that could affect the current work.
